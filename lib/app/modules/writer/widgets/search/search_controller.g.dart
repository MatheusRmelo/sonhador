// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchController on _SearchControllerBase, Store {
  final _$textsAtom = Atom(name: '_SearchControllerBase.texts');

  @override
  ObservableFuture<List<TextModel>> get texts {
    _$textsAtom.reportRead();
    return super.texts;
  }

  @override
  set texts(ObservableFuture<List<TextModel>> value) {
    _$textsAtom.reportWrite(value, super.texts, () {
      super.texts = value;
    });
  }

  final _$textsOldAtom = Atom(name: '_SearchControllerBase.textsOld');

  @override
  ObservableFuture<List<TextModel>> get textsOld {
    _$textsOldAtom.reportRead();
    return super.textsOld;
  }

  @override
  set textsOld(ObservableFuture<List<TextModel>> value) {
    _$textsOldAtom.reportWrite(value, super.textsOld, () {
      super.textsOld = value;
    });
  }

  final _$_SearchControllerBaseActionController =
      ActionController(name: '_SearchControllerBase');

  @override
  void fetchTexts(String userId) {
    final _$actionInfo = _$_SearchControllerBaseActionController.startAction(
        name: '_SearchControllerBase.fetchTexts');
    try {
      return super.fetchTexts(userId);
    } finally {
      _$_SearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchText(String userId, String textSearch) {
    final _$actionInfo = _$_SearchControllerBaseActionController.startAction(
        name: '_SearchControllerBase.searchText');
    try {
      return super.searchText(userId, textSearch);
    } finally {
      _$_SearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
texts: ${texts},
textsOld: ${textsOld}
    ''';
  }
}
