// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discovery_search_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DiscoverySearchController on _DiscoverySearchControllerBase, Store {
  final _$textsAtom = Atom(name: '_DiscoverySearchControllerBase.texts');

  @override
  ObservableFuture<List<DiscoveryTextModel>> get texts {
    _$textsAtom.reportRead();
    return super.texts;
  }

  @override
  set texts(ObservableFuture<List<DiscoveryTextModel>> value) {
    _$textsAtom.reportWrite(value, super.texts, () {
      super.texts = value;
    });
  }

  final _$usersAtom = Atom(name: '_DiscoverySearchControllerBase.users');

  @override
  ObservableFuture<List<DiscoveryUserModel>> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableFuture<List<DiscoveryUserModel>> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$_timerAtom = Atom(name: '_DiscoverySearchControllerBase._timer');

  @override
  Timer get _timer {
    _$_timerAtom.reportRead();
    return super._timer;
  }

  @override
  set _timer(Timer value) {
    _$_timerAtom.reportWrite(value, super._timer, () {
      super._timer = value;
    });
  }

  final _$_DiscoverySearchControllerBaseActionController =
      ActionController(name: '_DiscoverySearchControllerBase');

  @override
  void searchText(String textSearch) {
    final _$actionInfo = _$_DiscoverySearchControllerBaseActionController
        .startAction(name: '_DiscoverySearchControllerBase.searchText');
    try {
      return super.searchText(textSearch);
    } finally {
      _$_DiscoverySearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchUser(String textSearch) {
    final _$actionInfo = _$_DiscoverySearchControllerBaseActionController
        .startAction(name: '_DiscoverySearchControllerBase.searchUser');
    try {
      return super.searchUser(textSearch);
    } finally {
      _$_DiscoverySearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
texts: ${texts},
users: ${users}
    ''';
  }
}
