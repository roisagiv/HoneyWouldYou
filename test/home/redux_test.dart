import 'dart:async';
import 'package:honeywouldyou/data/list_repository.dart';
import 'package:honeywouldyou/home/models.dart';
import 'package:honeywouldyou/home/redux.dart';
import 'package:honeywouldyou/redux/redux.dart';
import 'package:test/test.dart';

void main() {
  group('store', () {
    test('smoke', () async {
      final store = createStore(new TestableListRepository())
        ..dispatch(new OnHomePageConnectedAction());

      await new Future.delayed(new Duration(milliseconds: 1));
      expect(store.state.lists, new AppState([]).lists);
    });
  });
}

///
class TestableListRepository extends ListRepository {
  ///
  @override
  Future<List<ListModel>> listsAsFuture() => new Future.value([]);
}
