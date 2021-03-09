// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discovery_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DiscoveryController on _DiscoveryControllerBase, Store {
  final _$textsAtom = Atom(name: '_DiscoveryControllerBase.texts');

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

  final _$usersAtom = Atom(name: '_DiscoveryControllerBase.users');

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

  final _$_DiscoveryControllerBaseActionController =
      ActionController(name: '_DiscoveryControllerBase');

  @override
  void fetchTexts() {
    final _$actionInfo = _$_DiscoveryControllerBaseActionController.startAction(
        name: '_DiscoveryControllerBase.fetchTexts');
    try {
      return super.fetchTexts();
    } finally {
      _$_DiscoveryControllerBaseActionController.endAction(_$actionInfo);
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
