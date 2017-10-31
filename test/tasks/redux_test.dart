import 'dart:async';

import 'package:honeywouldyou/home/redux.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:honeywouldyou/tasks/redux.dart';
import 'package:test/test.dart';

import '../data/testable_list_repository.dart';

///
void main() {
  ///
  group('tasks', () {
    var store;
    setUp(() async {
      store = createStore(new TestableListRepository())
        ..dispatch(new OnHomePageConnectedAction());

      await new Future.delayed(new Duration(milliseconds: 10));
    });

    ///
    test('OnTaskCompleteToggledAction', () async {
      store.dispatch(new OnTaskCompleteToggledAction(
          const OnTaskCompleteToggledData(
              taskId: '59e6ee115379cbbf5bc402d5',
              listId: '59e6ee11e01f193d97235993',
              completed: true)));

      expect(store.state.lists[1].tasks[2].completed, true);
    });

    ///
    test('OnAddTaskAction', () async {
      store.dispatch(new OnAddTaskAction(new OnAddTaskActionData(
        name: 'name name',
        listId: '59e6ee11e01f193d97235993',
      )));

      expect(store.state.lists[1].tasks.length, 7);
    });
  });
}
