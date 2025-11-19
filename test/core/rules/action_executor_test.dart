import 'package:flutter_test/flutter_test.dart';
import 'package:filo/core/rules/action_executor.dart';
import 'package:filo/data/models/action_model.dart';
import 'package:filo/data/db/database.dart';
import 'package:drift/native.dart';

void main() {
  late FiloDatabase database;
  late ActionExecutor executor;

  setUp(() {
    database = FiloDatabase.forTesting(NativeDatabase.memory());
    executor = ActionExecutor(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('Move Action', () {
    test('move action with valid target', () async {
      // Insert test file
      final fileId = await database.filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: 'content://downloads/original/file.pdf',
          normalizedName: 'file.pdf',
          mime: 'application/pdf',
          size: 1024,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'abc123',
        ),
      );

      final file = await database.filesDao.getFileById(fileId);
      final action = ActionModel(
        type: ActionTypes.move,
        params: {'target': 'content://downloads/moved/file.pdf'},
      );

      final result = await executor.executeAction(action, file!);

      expect(result.success, true);
      expect(result.actionType, ActionTypes.move);
      expect(
        result.metadata?['old_uri'],
        'content://downloads/original/file.pdf',
      );
      expect(result.metadata?['new_uri'], 'content://downloads/moved/file.pdf');

      // Verify DB updated
      final updatedFile = await database.filesDao.getFileById(fileId);
      expect(updatedFile?.uri, 'content://downloads/moved/file.pdf');
    });

    test('move action with missing target parameter', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'file.pdf',
        mime: 'application/pdf',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: false,
      );

      final action = ActionModel(
        type: ActionTypes.move,
        params: {}, // Missing target
      );

      final result = await executor.executeAction(action, file);

      expect(result.success, false);
      expect(result.error, contains('Missing target parameter'));
    });

    test('move action with invalid URI format', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'file.pdf',
        mime: 'application/pdf',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: false,
      );

      final action = ActionModel(
        type: ActionTypes.move,
        params: {'target': 'invalid-uri'},
      );

      final result = await executor.executeAction(action, file);

      expect(result.success, false);
      expect(result.error, contains('Invalid target URI format'));
    });
  });

  group('Rename Action', () {
    test('rename action with pattern', () async {
      // Insert test file
      final fileId = await database.filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: 'content://downloads/old_name.pdf',
          normalizedName: 'old_name.pdf',
          mime: 'application/pdf',
          size: 1024,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'abc123',
        ),
      );

      final file = await database.filesDao.getFileById(fileId);
      final action = ActionModel(
        type: ActionTypes.rename,
        params: {'pattern': '{name}_renamed.{ext}'},
      );

      final result = await executor.executeAction(action, file!);

      expect(result.success, true);
      expect(result.actionType, ActionTypes.rename);
      expect(result.metadata?['old_name'], 'old_name.pdf');
      expect(result.metadata?['new_name'], 'old_name_renamed.pdf');
    });

    test('rename with date token', () async {
      final fileId = await database.filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: 'content://downloads/report.pdf',
          normalizedName: 'report.pdf',
          mime: 'application/pdf',
          size: 1024,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'xyz',
        ),
      );

      final file = await database.filesDao.getFileById(fileId);
      final action = ActionModel(
        type: ActionTypes.rename,
        params: {'pattern': 'report_{date}.{ext}'},
      );

      final result = await executor.executeAction(action, file!);

      expect(result.success, true);
      expect(result.metadata?['new_name'], contains('report_'));
      expect(result.metadata?['new_name'], endsWith('.pdf'));
    });

    test('rename action with missing pattern', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'file.pdf',
        mime: 'application/pdf',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: false,
      );

      final action = ActionModel(type: ActionTypes.rename, params: {});

      final result = await executor.executeAction(action, file);

      expect(result.success, false);
      expect(result.error, contains('Missing pattern parameter'));
    });
  });

  group('Add Tag Action', () {
    test('add_tag action with single tag', () async {
      final fileId = await database.filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: 'content://downloads/document.pdf',
          normalizedName: 'document.pdf',
          mime: 'application/pdf',
          size: 1024,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'abc',
        ),
      );

      final file = await database.filesDao.getFileById(fileId);
      final action = ActionModel(
        type: ActionTypes.addTag,
        params: {'tags': 'important'},
      );

      final result = await executor.executeAction(action, file!);

      expect(result.success, true);
      expect(result.metadata?['tags'], contains('important'));

      // Verify logged to activity_log
      final logs = await database.activityLogDao.getAllActivityLogs();
      expect(logs.any((log) => log.activityType == 'tag_added'), true);
    });

    test('add_tag action with multiple tags', () async {
      final fileId = await database.filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: 'content://downloads/photo.jpg',
          normalizedName: 'photo.jpg',
          mime: 'image/jpeg',
          size: 2048,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'xyz',
        ),
      );

      final file = await database.filesDao.getFileById(fileId);
      final action = ActionModel(
        type: ActionTypes.addTag,
        params: {
          'tags': ['vacation', 'family', '2024'],
        },
      );

      final result = await executor.executeAction(action, file!);

      expect(result.success, true);
      expect(result.metadata?['tags'], hasLength(3));
    });

    test('add_tag action with missing tags', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'file.pdf',
        mime: 'application/pdf',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: false,
      );

      final action = ActionModel(type: ActionTypes.addTag, params: {});

      final result = await executor.executeAction(action, file);

      expect(result.success, false);
      expect(result.error, contains('Missing tags parameter'));
    });
  });

  group('Notify Action', () {
    test('notify action with message', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'file.pdf',
        mime: 'application/pdf',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: false,
      );

      final action = ActionModel(
        type: ActionTypes.notify,
        params: {'message': 'File processed successfully'},
      );

      final result = await executor.executeAction(action, file);

      expect(result.success, true);
      expect(result.metadata?['message'], 'File processed successfully');
      expect(result.metadata?['file_name'], 'file.pdf');
    });

    test('notify action with missing message', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'file.pdf',
        mime: 'application/pdf',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: false,
      );

      final action = ActionModel(type: ActionTypes.notify, params: {});

      final result = await executor.executeAction(action, file);

      expect(result.success, false);
      expect(result.error, contains('Missing message parameter'));
    });
  });

  group('Multiple Actions', () {
    test('execute multiple actions - all succeed', () async {
      final fileId = await database.filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: 'content://downloads/file.pdf',
          normalizedName: 'file.pdf',
          mime: 'application/pdf',
          size: 1024,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'abc',
        ),
      );

      final file = await database.filesDao.getFileById(fileId);
      final actions = [
        ActionModel(type: ActionTypes.addTag, params: {'tags': 'processed'}),
        ActionModel(
          type: ActionTypes.notify,
          params: {'message': 'File processed'},
        ),
      ];

      final results = await executor.executeActions(actions, file!);

      expect(results, hasLength(2));
      expect(results[0].success, true);
      expect(results[1].success, true);
    });

    test('execute multiple actions - stop on first failure', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'file.pdf',
        mime: 'application/pdf',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: false,
      );

      final actions = [
        ActionModel(
          type: ActionTypes.move,
          params: {},
        ), // Missing target, will fail
        ActionModel(
          type: ActionTypes.notify,
          params: {'message': 'Should not execute'},
        ),
      ];

      final results = await executor.executeActions(actions, file);

      expect(results, hasLength(1)); // Only first action executed
      expect(results[0].success, false);
    });
  });

  group('Unknown Action Type', () {
    test('unknown action type returns failure', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'file.pdf',
        mime: 'application/pdf',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: false,
      );

      final action = ActionModel(type: 'unknown_action', params: {});

      final result = await executor.executeAction(action, file);

      expect(result.success, false);
      expect(result.error, contains('Unknown action type'));
    });
  });
}
