// GENERATED CODE - DO NOT MODIFY BY HAND

part of redux;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$AppState extends AppState {
  @override
  final BuiltList<ListModel> lists;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.lists}) : super._() {
    if (lists == null) throw new ArgumentError.notNull('lists');
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! AppState) return false;
    return lists == other.lists;
  }

  @override
  int get hashCode {
    return $jf($jc(0, lists.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')..add('lists', lists))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  ListBuilder<ListModel> _lists;
  ListBuilder<ListModel> get lists =>
      _$this._lists ??= new ListBuilder<ListModel>();
  set lists(ListBuilder<ListModel> lists) => _$this._lists = lists;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _lists = _$v.lists?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    final _$result = _$v ?? new _$AppState._(lists: lists?.build());
    replace(_$result);
    return _$result;
  }
}
