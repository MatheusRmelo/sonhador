// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchController on _SearchControllerBase, Store {
  final _$textsListAtom = Atom(name: '_SearchControllerBase.textsList');

  @override
  ObservableFuture<List<TextModel>> get textsList {
    _$textsListAtom.reportRead();
    return super.textsList;
  }

  @override
  set textsList(ObservableFuture<List<TextModel>> value) {
    _$textsListAtom.reportWrite(value, super.textsList, () {
      super.textsList = value;
    });
  }

  final _$textsAtom = Atom(name: '_SearchControllerBase.texts');

  @override
  List<TextModel> get texts {
    _$textsAtom.reportRead();
    return super.texts;
  }

  @override
  set texts(List<TextModel> value) {
    _$textsAtom.reportWrite(value, super.texts, () {
      super.texts = value;
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
  void searchText(String textSearch) {
    final _$actionInfo = _$_SearchControllerBaseActionController.startAction(
        name: '_SearchControllerBase.searchText');
    try {
      return super.searchText(textSearch);
    } finally {
      _$_SearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
textsList: ${textsList},
texts: ${texts}
    ''';
  }
}
