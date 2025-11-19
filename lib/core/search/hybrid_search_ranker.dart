import 'package:drift/drift.dart';
import '../../data/db/database.dart';
import 'semantic_search_service.dart';

/// Hybrid search result with combined scoring
class HybridSearchResult {
  final FileIndexEntry file;
  final double finalScore;
  final double keywordScore;
  final double semanticScore;
  final double recencyScore;

  HybridSearchResult({
    required this.file,
    required this.finalScore,
    required this.keywordScore,
    required this.semanticScore,
    required this.recencyScore,
  });
}

/// Keyword search result
class KeywordSearchResult {
  final int fileId;
  final double score;

  KeywordSearchResult({required this.fileId, required this.score});
}

/// Score components for hybrid ranking
class HybridScoreComponents {
  double keywordScore;
  double semanticScore;
  double recencyScore;

  HybridScoreComponents({
    required this.keywordScore,
    required this.semanticScore,
    required this.recencyScore,
  });
}

/// Hybrid Search Ranker
///
/// Combines keyword (FTS) and semantic search with recency bonus
/// Per search_architecture_ultra.md: 0.55 * keyword + 0.35 * semantic + 0.10 * recency
class HybridSearchRanker {
  final FiloDatabase database;
  final SemanticSearchService semanticSearch;

  // Weights from spec
  static const double keywordWeight = 0.55;
  static const double semanticWeight = 0.35;
  static const double recencyWeight = 0.10;

  HybridSearchRanker(this.database, this.semanticSearch);

  /// Hybrid search combining keyword FTS and semantic similarity
  ///
  /// Returns ranked list of files with combined scores
  Future<List<HybridSearchResult>> search(
    String query, {
    int limit = 20,
  }) async {
    // Perform keyword search (FTS5)
    final keywordResults = await _keywordSearch(query, limit: limit * 2);

    // Perform semantic search
    final semanticResults = await semanticSearch.search(
      query,
      limit: limit * 2,
    );

    // Combine results
    final combinedScores = <int, HybridScoreComponents>{};

    // Add keyword scores
    for (final result in keywordResults) {
      combinedScores[result.fileId] = HybridScoreComponents(
        keywordScore: result.score,
        semanticScore: 0.0,
        recencyScore: 0.0,
      );
    }

    // Add semantic scores
    for (final result in semanticResults) {
      if (combinedScores.containsKey(result.fileId)) {
        combinedScores[result.fileId]!.semanticScore = result.similarity;
      } else {
        combinedScores[result.fileId] = HybridScoreComponents(
          keywordScore: 0.0,
          semanticScore: result.similarity,
          recencyScore: 0.0,
        );
      }
    }

    // Get file metadata for recency calculation
    final fileIds = combinedScores.keys.toList();
    final files = await database.filesDao.getFilesByIds(fileIds);

    // Calculate recency scores and final combined scores
    final results = <HybridSearchResult>[];
    for (final file in files) {
      final components = combinedScores[file.id]!;

      // Calculate recency score (newer files score higher)
      components.recencyScore = _calculateRecencyScore(file.modifiedAt);

      // Calculate weighted final score
      final finalScore =
          (keywordWeight * components.keywordScore) +
          (semanticWeight * components.semanticScore) +
          (recencyWeight * components.recencyScore);

      results.add(
        HybridSearchResult(
          file: file,
          finalScore: finalScore,
          keywordScore: components.keywordScore,
          semanticScore: components.semanticScore,
          recencyScore: components.recencyScore,
        ),
      );
    }

    // Sort by final score (descending) and limit
    results.sort((a, b) => b.finalScore.compareTo(a.finalScore));
    return results.take(limit).toList();
  }

  /// Perform keyword search using FTS5
  Future<List<KeywordSearchResult>> _keywordSearch(
    String query, {
    required int limit,
  }) async {
    // Search FTS5 table
    // Note: FTS5 match query - using raw SQL for now
    final ftsResults = await database
        .customSelect(
          'SELECT file_id FROM files_fts WHERE files_fts MATCH ? ORDER BY rank LIMIT ?',
          variables: [Variable.withString(query), Variable.withInt(limit)],
          readsFrom: {database.filesFts},
        )
        .get();

    // Get BM25 ranks (simplified - FTS5 provides ranks)
    final results = <KeywordSearchResult>[];
    for (var i = 0; i < ftsResults.length; i++) {
      final fileId = ftsResults[i].read<int>('file_id');
      // Normalize score to 0-1 range
      final score = 1.0 / (i + 1); // Simple ranking by position
      results.add(KeywordSearchResult(fileId: fileId, score: score));
    }

    return results;
  }

  /// Calculate recency score based on modification date
  ///
  /// Returns score between 0 and 1 (newer files score higher)
  double _calculateRecencyScore(DateTime modifiedAt) {
    final now = DateTime.now();
    final ageInDays = now.difference(modifiedAt).inDays;

    // Decay function: score decreases as age increases
    // Files modified in last 7 days get highest score
    // Score decays to ~0.1 after 365 days
    if (ageInDays < 7) {
      return 1.0;
    } else if (ageInDays < 30) {
      return 0.8;
    } else if (ageInDays < 90) {
      return 0.6;
    } else if (ageInDays < 180) {
      return 0.4;
    } else if (ageInDays < 365) {
      return 0.2;
    } else {
      return 0.1;
    }
  }
}
