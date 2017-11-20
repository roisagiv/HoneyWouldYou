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
    final String listId = '5a171ecc18a34083114ea3ff';

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
      final String taskId = '5a171ecc046531ef20a1fe4e';

      store.dispatch(new OnTaskCompleteToggledAction(
          new OnTaskCompleteToggledData(
              taskId: taskId, listId: listId, completed: true)));

      await aBit();

      expect(store.state.tasks[taskId].completed, true);
    });

    ///
    test('OnAddTaskAction', () async {
      expect(store.state.tasks.length, 14);
      store.dispatch(new OnAddTaskAction(new OnAddTaskActionData(
        name: 'name name',
        listId: listId,
      )));

      expect(store.state.tasks.length, 15);
    });
  });
}
