import 'package:faker/faker.dart';
import 'package:honeywouldyou/lists/redux.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/tasks/redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import '../auth/testable_authenticator.dart';
import '../data/testable_repository.dart';
import '../utils/utils.dart';

///
void main() {
  ///
  group('tasks', () {
    final String listId = '5a2422b307aae6fb9847d8c4';

    Store<AppState> store;
    TestableRepository repository;

    setUp(() async {
      repository = new TestableRepository();
      await repository.init();

      store = createStore(
          repository: repository,
          authenticator: new TestableAuthenticator.configured())
        ..dispatch(new OnSplashInitAction());
      await aBit();

      store.dispatch(new OnListsPageConnectedAction());
      await aBit();

      store.dispatch(new OnTasksPageConnectedAction(listId: listId));
      await aBit();
    });

    ///
    test('OnTaskCompleteToggledAction', () async {
      final String taskId = '5a2422b3a914e314b4eee423';

      store.dispatch(new OnTaskCompleteToggledAction(
          new OnTaskCompleteToggledData(
              taskId: taskId, listId: listId, completed: true)));

      await aBit();

      expect(store.state.tasks[taskId].completed, true);
    });

    ///
    test('OnAddTaskAction', () async {
      expect(store.state.tasks.length, 6);
      final String taskName = faker.randomGenerator.string(9);

      store.dispatch(new OnAddTaskAction(new OnAddTaskActionData(
        name: taskName,
        listId: listId,
      )));

      await aBit();
      expect(store.state.tasks.length, 7);
      expect(repository.lastAddedTask.name, taskName);
      expect(repository.lastAddedTask.listId, listId);
    });
  });
}
