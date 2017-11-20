import 'package:honeywouldyou/data/models.dart';
import 'package:honeywouldyou/lists/redux.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import '../auth/testable_authenticator.dart';
import '../data/testable_repository.dart';
import '../utils/utils.dart';

void main() {
  group('lists', () {
    Store<AppState> store;
    TestableRepository repository;

    setUp(() async {
      repository = new TestableRepository();
      await repository.init();

      store = createStore(
          logging: true,
          repository: repository,
          authenticator: new TestableAuthenticator.configured())
        ..dispatch(new OnSplashInitAction());

      await aBit();
      store.dispatch(new OnListsPageConnectedAction());
      await aBit();
    });

    test('OnListsPageConnectedAction', () async {
      expect(store.state.lists.length, 7);
    });

    test('OnAddNewListSaveClickedAction', () async {
      store.dispatch(new OnAddNewListSaveClickedAction('new list'));
      await aBit();
      expect(store.state.lists.length, 8);

      final ListModel list = store.state.lists.values
          .firstWhere((ListModel l) => l.name == 'new list');

      expect(repository.lastAddedTask, list);

      expect(list.name, 'new list');
      expect(list.tasks?.length, 0);
      expect(list.id, isNotEmpty);
    });

    test('OnRemoveListSaveClickedAction', () async {
      final String listId = store.state.lists.keys.first;
      store.dispatch(new OnRemoveListClickedAction(listId));

      await aBit();

      expect(store.state.lists.length, 6);
      expect(repository.lastRemovedListId, listId);
    });
  });
}
