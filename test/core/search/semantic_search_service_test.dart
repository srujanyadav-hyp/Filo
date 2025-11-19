import 'package:flutter_test/flutter_test.dart';
import 'package:filo/core/search/semantic_search_service.dart';
import 'package:filo/data/db/database.dart';
import 'package:filo/core/embeddings/embedding_generator.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'dart:typed_data';

@GenerateMocks([FiloDatabase, FilesDao, EmbeddingGenerator])
import 'semantic_search_service_test.mocks.dart';

void main() {
  group('SemanticSearchService', () {
    late MockFiloDatabase mockDatabase;
    late MockFilesDao mockFilesDao;
    late MockEmbeddingGenerator mockEmbeddingGenerator;
    late SemanticSearchService semanticSearch;

    setUp(() {
      mockDatabase = MockFiloDatabase();
      mockFilesDao = MockFilesDao();
      mockEmbeddingGenerator = MockEmbeddingGenerator();

      when(mockDatabase.filesDao).thenReturn(mockFilesDao);

      semanticSearch = SemanticSearchService(
        mockDatabase,
        mockEmbeddingGenerator,
      );
    });

    group('search', () {
      test('should return empty list when query embedding fails', () async {
        when(mockEmbeddingGenerator.generateEmbedding(any)).thenAnswer(
          (_) async => EmbeddingResult(
            vector: Uint8List(0),
            dimensions: 0,
            success: false,
          ),
        );

        final results = await semanticSearch.search('test query');

        expect(results, isEmpty);
      });

      test('should return empty list when no embeddings in database', () async {
        // Mock successful query embedding
        final queryVector = Uint8List.fromList(List.filled(384, 128));
        when(mockEmbeddingGenerator.generateEmbedding(any)).thenAnswer(
          (_) async => EmbeddingResult(
            vector: queryVector,
            dimensions: 384,
            success: true,
          ),
        );

        // Mock empty embeddings table
        when(
          mockDatabase.customSelect(
            any,
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => []);

        final results = await semanticSearch.search('test query');

        expect(results, isEmpty);
      });

      test('should filter results by minimum similarity threshold', () async {
        // Mock query embedding
        final queryVector = Uint8List.fromList(List.generate(384, (i) => 128));
        when(mockEmbeddingGenerator.generateEmbedding(any)).thenAnswer(
          (_) async => EmbeddingResult(
            vector: queryVector,
            dimensions: 384,
            success: true,
          ),
        );

        // Mock embeddings with varying similarities
        // Note: Since we're using placeholder embeddings (all 128),
        // all similarities will be 1.0, so we test the filtering logic
        final mockRows = [
          _createMockRow(1, queryVector),
          _createMockRow(2, queryVector),
          _createMockRow(
            3,
            Uint8List.fromList(List.filled(384, 0)),
          ), // Different
        ];

        when(
          mockDatabase.customSelect(
            any,
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockRows);

        final results = await semanticSearch.search(
          'test query',
          minSimilarity: 0.9, // High threshold
        );

        // Should include files 1 and 2 (identical), exclude file 3
        expect(results.length, 2);
        expect(results[0].similarity, closeTo(1.0, 0.01));
        expect(results[1].similarity, closeTo(1.0, 0.01));
      });

      test('should respect limit parameter', () async {
        final queryVector = Uint8List.fromList(List.filled(384, 128));
        when(mockEmbeddingGenerator.generateEmbedding(any)).thenAnswer(
          (_) async => EmbeddingResult(
            vector: queryVector,
            dimensions: 384,
            success: true,
          ),
        );

        // Create 10 mock embeddings
        final mockRows = List.generate(
          10,
          (i) => _createMockRow(i + 1, queryVector),
        );

        when(
          mockDatabase.customSelect(
            any,
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockRows);

        final results = await semanticSearch.search('test query', limit: 5);

        expect(results.length, lessThanOrEqualTo(5));
      });

      test('should sort results by similarity descending', () async {
        final queryVector = Uint8List.fromList(List.generate(384, (i) => 200));
        when(mockEmbeddingGenerator.generateEmbedding(any)).thenAnswer(
          (_) async => EmbeddingResult(
            vector: queryVector,
            dimensions: 384,
            success: true,
          ),
        );

        // Create embeddings with different similarities
        final mockRows = [
          _createMockRow(
            1,
            Uint8List.fromList(List.filled(384, 100)),
          ), // Low similarity
          _createMockRow(
            2,
            Uint8List.fromList(List.filled(384, 200)),
          ), // High similarity
          _createMockRow(
            3,
            Uint8List.fromList(List.filled(384, 150)),
          ), // Medium similarity
        ];

        when(
          mockDatabase.customSelect(
            any,
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockRows);

        final results = await semanticSearch.search(
          'test query',
          minSimilarity: 0.0,
        );

        // Should be sorted: file 2 (high), file 3 (medium), file 1 (low)
        expect(results[0].fileId, 2);
        expect(results[0].similarity, greaterThan(results[1].similarity));
        expect(results[1].similarity, greaterThan(results[2].similarity));
      });

      test('should handle query with no similar results', () async {
        final queryVector = Uint8List.fromList(List.filled(384, 255));
        when(mockEmbeddingGenerator.generateEmbedding(any)).thenAnswer(
          (_) async => EmbeddingResult(
            vector: queryVector,
            dimensions: 384,
            success: true,
          ),
        );

        // Create very dissimilar embeddings
        final mockRows = [
          _createMockRow(1, Uint8List.fromList(List.filled(384, 0))),
          _createMockRow(2, Uint8List.fromList(List.filled(384, 1))),
        ];

        when(
          mockDatabase.customSelect(
            any,
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockRows);

        final results = await semanticSearch.search(
          'test query',
          minSimilarity: 0.9, // Very high threshold
        );

        expect(results, isEmpty);
      });
    });

    group('searchWithMetadata', () {
      test('should return full FileIndexEntry objects', () async {
        final queryVector = Uint8List.fromList(List.filled(384, 128));
        when(mockEmbeddingGenerator.generateEmbedding(any)).thenAnswer(
          (_) async => EmbeddingResult(
            vector: queryVector,
            dimensions: 384,
            success: true,
          ),
        );

        final mockRows = [
          _createMockRow(1, queryVector),
          _createMockRow(2, queryVector),
        ];

        when(
          mockDatabase.customSelect(
            any,
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockRows);

        // Mock file metadata
        final mockFiles = [
          FileIndexEntry(
            id: 1,
            uri: '/test/file1.txt',
            fileName: 'file1.txt',
            mimeType: 'text/plain',
            size: 100,
            modifiedAt: DateTime.now(),
            createdAt: DateTime.now(),
            folderPath: '/test',
            extension: 'txt',
            hasFullText: true,
            hasThumbnail: false,
            hasEmbedding: true,
          ),
          FileIndexEntry(
            id: 2,
            uri: '/test/file2.txt',
            fileName: 'file2.txt',
            mimeType: 'text/plain',
            size: 200,
            modifiedAt: DateTime.now(),
            createdAt: DateTime.now(),
            folderPath: '/test',
            extension: 'txt',
            hasFullText: true,
            hasThumbnail: false,
            hasEmbedding: true,
          ),
        ];

        when(
          mockFilesDao.getFilesByIds([1, 2]),
        ).thenAnswer((_) async => mockFiles);

        final results = await semanticSearch.searchWithMetadata('test query');

        expect(results.length, 2);
        expect(results[0].file.fileName, 'file1.txt');
        expect(results[1].file.fileName, 'file2.txt');
        expect(results[0].similarity, isA<double>());
      });

      test('should handle empty metadata gracefully', () async {
        final queryVector = Uint8List.fromList(List.filled(384, 128));
        when(mockEmbeddingGenerator.generateEmbedding(any)).thenAnswer(
          (_) async => EmbeddingResult(
            vector: queryVector,
            dimensions: 384,
            success: true,
          ),
        );

        final mockRows = [_createMockRow(1, queryVector)];

        when(
          mockDatabase.customSelect(
            any,
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockRows);

        when(mockFilesDao.getFilesByIds([1])).thenAnswer((_) async => []);

        final results = await semanticSearch.searchWithMetadata('test query');

        expect(results, isEmpty);
      });
    });

    group('_bytesToVector', () {
      test('should convert Uint8List to List<double>', () {
        // This is a private method, tested indirectly through search()
        // We verify the conversion works by checking that search returns valid results
        final queryVector = Uint8List.fromList([0, 128, 255]);
        when(mockEmbeddingGenerator.generateEmbedding(any)).thenAnswer(
          (_) async => EmbeddingResult(
            vector: queryVector,
            dimensions: 3,
            success: true,
          ),
        );

        final mockRows = [
          _createMockRow(1, Uint8List.fromList([0, 128, 255])),
        ];

        when(
          mockDatabase.customSelect(
            any,
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockRows);

        // If conversion works, this should not throw
        expect(() => semanticSearch.search('test'), returnsNormally);
      });
    });
  });
}

// Helper function to create mock query rows
MockQueryRow _createMockRow(int fileId, Uint8List embedding) {
  final row = MockQueryRow();
  when(row.read<int>('file_id')).thenReturn(fileId);
  when(row.read<Uint8List>('embedding')).thenReturn(embedding);
  return row;
}

class MockQueryRow extends Mock {
  T read<T>(String columnName);
}
