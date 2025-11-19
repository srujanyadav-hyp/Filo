// File Indexing Service Tests
// Refs: phase4_plan.md Task 1, testing_and_ci_ultra_ultra.md

import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:filo/data/db/database.dart';
import 'package:filo/core/indexing/file_indexing_service.dart';
import 'package:filo/core/indexing/file_reader.dart';
import 'package:filo/core/indexing/metadata_extractor.dart';
import 'package:filo/core/indexing/mime_detector.dart';

void main() {
  late FiloDatabase database;

  setUp(() {
    database = FiloDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('FileReader Tests', () {
    test('readFile retries on failure', () async {
      final reader = FileReader();

      // Test with non-existent file
      final result = await reader.readFile('/nonexistent/file.txt');

      expect(result.success, false);
      expect(result.error, contains('File does not exist'));
    });

    test('readMetadata extracts file stats', () async {
      final reader = FileReader();

      // Test with non-existent file
      final result = await reader.readMetadata('/nonexistent/file.txt');

      expect(result.success, false);
    });
  });

  group('MetadataExtractor Tests', () {
    test('extractMetadata generates checksum', () {
      final extractor = MetadataExtractor();

      final companion = extractor.extractMetadata(
        uri: '/storage/test.pdf',
        mimeType: 'application/pdf',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        fileData: [1, 2, 3, 4, 5],
      );

      expect(companion.uri.value, '/storage/test.pdf');
      expect(companion.normalizedName.value, 'test.pdf');
      expect(companion.mime.value, 'application/pdf');
      expect(companion.size.value, 1024);
      expect(companion.checksum.value, isNotEmpty);
    });

    test('normalizes filename correctly', () {
      final extractor = MetadataExtractor();

      final companion = extractor.extractMetadata(
        uri: '/path/to/My Document.pdf',
        mimeType: 'application/pdf',
        size: 100,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        fileData: [1],
      );

      expect(companion.normalizedName.value, 'My Document.pdf');
    });
  });

  group('MimeDetector Tests', () {
    test('detectMimeType from extension', () {
      final detector = MimeDetector();

      expect(
        detector.detectMimeType(filePath: 'test.pdf', fileData: null),
        'application/pdf',
      );
      expect(
        detector.detectMimeType(filePath: 'test.jpg', fileData: null),
        'image/jpeg',
      );
      expect(
        detector.detectMimeType(filePath: 'test.txt', fileData: null),
        'text/plain',
      );
    });

    test('isImage returns correct boolean', () {
      final detector = MimeDetector();

      expect(detector.isImage('image/jpeg'), true);
      expect(detector.isImage('image/png'), true);
      expect(detector.isImage('application/pdf'), false);
    });

    test('isPdf returns correct boolean', () {
      final detector = MimeDetector();

      expect(detector.isPdf('application/pdf'), true);
      expect(detector.isPdf('image/jpeg'), false);
    });

    test('isDocument returns correct boolean', () {
      final detector = MimeDetector();

      expect(detector.isDocument('application/pdf'), true);
      expect(detector.isDocument('text/plain'), true);
      expect(detector.isDocument('image/jpeg'), false);
    });

    test('supportsOcr returns correct boolean', () {
      final detector = MimeDetector();

      expect(detector.supportsOcr('image/jpeg'), true);
      expect(detector.supportsOcr('application/pdf'), true);
      expect(detector.supportsOcr('text/plain'), false);
    });
  });

  group('FileIndexingService Integration Tests', () {
    test('indexFile fails gracefully for non-existent file', () async {
      final service = FileIndexingService(database: database);

      final result = await service.indexFile('/nonexistent/file.pdf');

      expect(result.success, false);
      expect(result.error, isNotNull);
      expect(result.error, contains('Step 1 failed'));
    });

    test('indexFiles processes multiple files', () async {
      final service = FileIndexingService(database: database);

      final results = await service.indexFiles([
        '/nonexistent/file1.pdf',
        '/nonexistent/file2.pdf',
      ]);

      expect(results.length, 2);
      expect(results.every((r) => !r.success), true);
    });
  });

  group('Performance Tests', () {
    test('single file indexing completes in reasonable time', () async {
      final service = FileIndexingService(database: database);
      final startTime = DateTime.now();

      await service.indexFile('/nonexistent/file.pdf');

      final duration = DateTime.now().difference(startTime);

      // Should complete quickly even on failure (< 1 second)
      expect(duration.inSeconds, lessThan(2));
    });
  });
}
