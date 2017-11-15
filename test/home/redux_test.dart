import 'dart:async';

import 'package:honeywouldyou/lists/redux.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import '../auth/testable_authenticator.dart';
import '../data/testable_repository.dart';

void main() {
  group('lists', () {
    test('OnListsPageConnectedAction', () async {
      final Store<AppState> store = createStore(
          repository: new TestableRepository(),
          authenticator: new TestableAuthenticator.configured())
        ..dispatch(new OnSplashInitAction());

      await new Future<Null>.delayed(new Duration(milliseconds: 200));

      store.dispatch(new OnListsPageConnectedAction());

      await new Future<Null>.delayed(new Duration(milliseconds: 100));
      expect(store.state.lists.length, 30);
    });
  });
}
