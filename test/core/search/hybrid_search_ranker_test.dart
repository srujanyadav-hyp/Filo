import 'package:flutter_test/flutter_test.dart';
import 'package:filo/core/search/hybrid_search_ranker.dart';
import 'package:filo/core/search/semantic_search_service.dart';
import 'package:filo/data/db/database.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([FiloDatabase, FilesDao, SemanticSearchService])
import 'hybrid_search_ranker_test.mocks.dart';

void main() {
  group('HybridSearchRanker', () {
    late MockFiloDatabase mockDatabase;
    late MockFilesDao mockFilesDao;
    late MockSemanticSearchService mockSemanticSearch;
    late HybridSearchRanker hybridRanker;

    setUp(() {
      mockDatabase = MockFiloDatabase();
      mockFilesDao = MockFilesDao();
      mockSemanticSearch = MockSemanticSearchService();

      when(mockDatabase.filesDao).thenReturn(mockFilesDao);

      hybridRanker = HybridSearchRanker(mockDatabase, mockSemanticSearch);
    });

    group('search', () {
      test('should combine keyword and semantic results', () async {
        // Mock keyword search results (via FTS5)
        final mockFtsRows = [
          _createMockFtsRow(1), // File 1 from keyword
          _createMockFtsRow(2), // File 2 from keyword
        ];

        when(
          mockDatabase.customSelect(
            argThat(contains('files_fts')),
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockFtsRows);

        // Mock semantic search results
        when(
          mockSemanticSearch.search(any, limit: anyNamed('limit')),
        ).thenAnswer(
          (_) async => [
            SemanticSearchResult(
              fileId: 2,
              similarity: 0.9,
            ), // File 2 from semantic
            SemanticSearchResult(
              fileId: 3,
              similarity: 0.8,
            ), // File 3 from semantic
          ],
        );

        // Mock file metadata
        final now = DateTime.now();
        final mockFiles = [
          _createMockFile(1, now.subtract(const Duration(days: 1))),
          _createMockFile(2, now.subtract(const Duration(days: 5))),
          _createMockFile(3, now.subtract(const Duration(days: 10))),
        ];

        when(
          mockFilesDao.getFilesByIds(any),
        ).thenAnswer((_) async => mockFiles);

        final results = await hybridRanker.search('test query', limit: 10);

        // Should have 3 unique files (1 from keyword only, 2 from both, 3 from semantic only)
        expect(results.length, 3);

        // File 2 should rank highest (has both keyword and semantic)
        expect(results[0].file.id, 2);
        expect(results[0].keywordScore, greaterThan(0));
        expect(results[0].semanticScore, greaterThan(0));
        expect(results[0].recencyScore, greaterThan(0));
      });

      test(
        'should apply correct weights: 0.55 keyword + 0.35 semantic + 0.10 recency',
        () async {
          final mockFtsRows = [_createMockFtsRow(1)];

          when(
            mockDatabase.customSelect(
              argThat(contains('files_fts')),
              variables: anyNamed('variables'),
              readsFrom: anyNamed('readsFrom'),
            ),
          ).thenAnswer((_) async => mockFtsRows);

          when(
            mockSemanticSearch.search(any, limit: anyNamed('limit')),
          ).thenAnswer(
            (_) async => [SemanticSearchResult(fileId: 1, similarity: 0.8)],
          );

          final now = DateTime.now();
          final mockFiles = [
            _createMockFile(1, now.subtract(const Duration(days: 3))),
          ];

          when(
            mockFilesDao.getFilesByIds(any),
          ).thenAnswer((_) async => mockFiles);

          final results = await hybridRanker.search('test query', limit: 10);

          expect(results.length, 1);

          // Verify score calculation
          // keywordScore = 1.0 (position 0)
          // semanticScore = 0.8
          // recencyScore = 1.0 (within 7 days)
          // finalScore = 0.55*1.0 + 0.35*0.8 + 0.10*1.0 = 0.55 + 0.28 + 0.10 = 0.93
          final expected = (0.55 * 1.0) + (0.35 * 0.8) + (0.10 * 1.0);
          expect(results[0].finalScore, closeTo(expected, 0.01));
        },
      );

      test('should handle keyword-only results', () async {
        final mockFtsRows = [_createMockFtsRow(1), _createMockFtsRow(2)];

        when(
          mockDatabase.customSelect(
            argThat(contains('files_fts')),
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockFtsRows);

        // No semantic results
        when(
          mockSemanticSearch.search(any, limit: anyNamed('limit')),
        ).thenAnswer((_) async => []);

        final now = DateTime.now();
        final mockFiles = [
          _createMockFile(1, now.subtract(const Duration(days: 5))),
          _createMockFile(2, now.subtract(const Duration(days: 10))),
        ];

        when(
          mockFilesDao.getFilesByIds(any),
        ).thenAnswer((_) async => mockFiles);

        final results = await hybridRanker.search('test query', limit: 10);

        expect(results.length, 2);
        expect(results[0].keywordScore, greaterThan(0));
        expect(results[0].semanticScore, 0.0);
        expect(results[0].recencyScore, greaterThan(0));
      });

      test('should handle semantic-only results', () async {
        // No keyword results
        when(
          mockDatabase.customSelect(
            argThat(contains('files_fts')),
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => []);

        when(
          mockSemanticSearch.search(any, limit: anyNamed('limit')),
        ).thenAnswer(
          (_) async => [
            SemanticSearchResult(fileId: 1, similarity: 0.9),
            SemanticSearchResult(fileId: 2, similarity: 0.7),
          ],
        );

        final now = DateTime.now();
        final mockFiles = [
          _createMockFile(1, now.subtract(const Duration(days: 5))),
          _createMockFile(2, now.subtract(const Duration(days: 10))),
        ];

        when(
          mockFilesDao.getFilesByIds(any),
        ).thenAnswer((_) async => mockFiles);

        final results = await hybridRanker.search('test query', limit: 10);

        expect(results.length, 2);
        expect(results[0].keywordScore, 0.0);
        expect(results[0].semanticScore, greaterThan(0));
        expect(results[0].recencyScore, greaterThan(0));
      });

      test('should sort by final score descending', () async {
        final mockFtsRows = [
          _createMockFtsRow(1), // Position 0: score 1.0
          _createMockFtsRow(2), // Position 1: score 0.5
        ];

        when(
          mockDatabase.customSelect(
            argThat(contains('files_fts')),
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockFtsRows);

        when(
          mockSemanticSearch.search(any, limit: anyNamed('limit')),
        ).thenAnswer(
          (_) async => [
            SemanticSearchResult(fileId: 2, similarity: 0.95), // High semantic
            SemanticSearchResult(fileId: 1, similarity: 0.5), // Low semantic
          ],
        );

        final now = DateTime.now();
        final mockFiles = [
          _createMockFile(1, now.subtract(const Duration(days: 5))),
          _createMockFile(2, now.subtract(const Duration(days: 5))),
        ];

        when(
          mockFilesDao.getFilesByIds(any),
        ).thenAnswer((_) async => mockFiles);

        final results = await hybridRanker.search('test query', limit: 10);

        // File 2 should rank higher despite lower keyword score
        // because it has much higher semantic score
        expect(results[0].finalScore, greaterThan(results[1].finalScore));
      });

      test('should respect limit parameter', () async {
        final mockFtsRows = List.generate(20, (i) => _createMockFtsRow(i + 1));

        when(
          mockDatabase.customSelect(
            argThat(contains('files_fts')),
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockFtsRows);

        when(
          mockSemanticSearch.search(any, limit: anyNamed('limit')),
        ).thenAnswer((_) async => []);

        final now = DateTime.now();
        final mockFiles = List.generate(
          20,
          (i) => _createMockFile(i + 1, now.subtract(Duration(days: i))),
        );

        when(
          mockFilesDao.getFilesByIds(any),
        ).thenAnswer((_) async => mockFiles);

        final results = await hybridRanker.search('test query', limit: 5);

        expect(results.length, lessThanOrEqualTo(5));
      });

      test('should handle empty query results', () async {
        when(
          mockDatabase.customSelect(
            argThat(contains('files_fts')),
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => []);

        when(
          mockSemanticSearch.search(any, limit: anyNamed('limit')),
        ).thenAnswer((_) async => []);

        final results = await hybridRanker.search('test query', limit: 10);

        expect(results, isEmpty);
      });
    });

    group('recency score calculation', () {
      test('files modified within 7 days should get score 1.0', () async {
        final mockFtsRows = [_createMockFtsRow(1)];

        when(
          mockDatabase.customSelect(
            argThat(contains('files_fts')),
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockFtsRows);

        when(
          mockSemanticSearch.search(any, limit: anyNamed('limit')),
        ).thenAnswer((_) async => []);

        final now = DateTime.now();
        final mockFiles = [
          _createMockFile(1, now.subtract(const Duration(days: 3))),
        ];

        when(
          mockFilesDao.getFilesByIds(any),
        ).thenAnswer((_) async => mockFiles);

        final results = await hybridRanker.search('test query', limit: 10);

        expect(results[0].recencyScore, 1.0);
      });

      test('files modified 30-90 days ago should get score 0.6', () async {
        final mockFtsRows = [_createMockFtsRow(1)];

        when(
          mockDatabase.customSelect(
            argThat(contains('files_fts')),
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockFtsRows);

        when(
          mockSemanticSearch.search(any, limit: anyNamed('limit')),
        ).thenAnswer((_) async => []);

        final now = DateTime.now();
        final mockFiles = [
          _createMockFile(1, now.subtract(const Duration(days: 60))),
        ];

        when(
          mockFilesDao.getFilesByIds(any),
        ).thenAnswer((_) async => mockFiles);

        final results = await hybridRanker.search('test query', limit: 10);

        expect(results[0].recencyScore, 0.6);
      });

      test('files older than 1 year should get score 0.1', () async {
        final mockFtsRows = [_createMockFtsRow(1)];

        when(
          mockDatabase.customSelect(
            argThat(contains('files_fts')),
            variables: anyNamed('variables'),
            readsFrom: anyNamed('readsFrom'),
          ),
        ).thenAnswer((_) async => mockFtsRows);

        when(
          mockSemanticSearch.search(any, limit: anyNamed('limit')),
        ).thenAnswer((_) async => []);

        final now = DateTime.now();
        final mockFiles = [
          _createMockFile(1, now.subtract(const Duration(days: 400))),
        ];

        when(
          mockFilesDao.getFilesByIds(any),
        ).thenAnswer((_) async => mockFiles);

        final results = await hybridRanker.search('test query', limit: 10);

        expect(results[0].recencyScore, 0.1);
      });

      test(
        'newer files should rank higher with same keyword/semantic scores',
        () async {
          final mockFtsRows = [_createMockFtsRow(1), _createMockFtsRow(2)];

          when(
            mockDatabase.customSelect(
              argThat(contains('files_fts')),
              variables: anyNamed('variables'),
              readsFrom: anyNamed('readsFrom'),
            ),
          ).thenAnswer((_) async => mockFtsRows);

          when(
            mockSemanticSearch.search(any, limit: anyNamed('limit')),
          ).thenAnswer(
            (_) async => [
              SemanticSearchResult(fileId: 1, similarity: 0.8),
              SemanticSearchResult(fileId: 2, similarity: 0.8),
            ],
          );

          final now = DateTime.now();
          final mockFiles = [
            _createMockFile(1, now.subtract(const Duration(days: 1))), // Recent
            _createMockFile(2, now.subtract(const Duration(days: 100))), // Old
          ];

          when(
            mockFilesDao.getFilesByIds(any),
          ).thenAnswer((_) async => mockFiles);

          final results = await hybridRanker.search('test query', limit: 10);

          // File 1 (recent) should rank higher than File 2 (old)
          expect(results[0].file.id, 1);
          expect(results[0].recencyScore, greaterThan(results[1].recencyScore));
        },
      );
    });
  });
}

// Helper functions
MockQueryRow _createMockFtsRow(int fileId) {
  final row = MockQueryRow();
  when(row.read<int>('file_id')).thenReturn(fileId);
  return row;
}

FileIndexEntry _createMockFile(int id, DateTime modifiedAt) {
  return FileIndexEntry(
    id: id,
    uri: '/test/file$id.txt',
    fileName: 'file$id.txt',
    mimeType: 'text/plain',
    size: 1000,
    modifiedAt: modifiedAt,
    createdAt: modifiedAt,
    folderPath: '/test',
    extension: 'txt',
    hasFullText: true,
    hasThumbnail: false,
    hasEmbedding: true,
  );
}

class MockQueryRow extends Mock {
  T read<T>(String columnName);
}
