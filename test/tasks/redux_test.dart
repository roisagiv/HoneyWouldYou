import 'dart:async';

import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/tasks/redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import '../auth/testable_authenticator.dart';
import '../data/testable_repository.dart';

///
void main() {
  ///
  group('tasks', () {
    Store<AppState> store;
    setUp(() async {
      store = createStore(
          repository: new TestableRepository(),
          authenticator: new TestableAuthenticator.configured())
        ..dispatch(new OnSplashInitAction());

      await new Future<Null>.delayed(new Duration(milliseconds: 100));
      store.dispatch(new OnTasksPageConnectedAction(listId: ''));

      await new Future<Null>.delayed(new Duration(milliseconds: 100));
    });

    ///
    test('OnTaskCompleteToggledAction', () async {
      store.dispatch(new OnTaskCompleteToggledAction(
          const OnTaskCompleteToggledData(
              taskId: '5a0edd1baac0f24cb45c4f2c',
              listId: '59e6ee11e01f193d97235993',
              completed: true)));

      expect(store.state.tasks['5a0edd1baac0f24cb45c4f2c'].completed, true);
    });

    ///
    test('OnAddTaskAction', () async {
      store.dispatch(new OnAddTaskAction(new OnAddTaskActionData(
        name: 'name name',
        listId: '59e6ee11e01f193d97235993',
      )));

      expect(store.state.tasks.length, 7);
    });
  });
}
