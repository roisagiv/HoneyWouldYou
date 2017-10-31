import 'dart:async';

import 'package:honeywouldyou/home/redux.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:test/test.dart';

import '../data/testable_list_repository.dart';

void main() {
  group('home', () {
    test('OnHomePageConnectedAction', () async {
      final store = createStore(new TestableListRepository())
        ..dispatch(new OnHomePageConnectedAction());

      await new Future.delayed(new Duration(milliseconds: 10));
      expect(store.state.lists.length, 7);
    });
  });
}
