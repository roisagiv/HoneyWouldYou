import 'dart:async';

import 'package:honeywouldyou/redux/redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import '../data/testable_list_repository.dart';

void main() {
  group('home', () {
    test('OnHomePageConnectedAction', () async {
      final Store<AppState> store =
          createStore(listRepository: new TestableListRepository())
            ..dispatch(new OnHomePageConnectedAction());

      await new Future<Null>.delayed(new Duration(milliseconds: 10));
      expect(store.state.lists.length, 7);
    });
  });
}
