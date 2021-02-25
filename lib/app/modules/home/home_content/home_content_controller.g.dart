// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_content_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeContentController on _HomeContentControllerBase, Store {
  final _$currentPageAtom =
      Atom(name: '_HomeContentControllerBase.currentPage');

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  final _$currentTextAtom =
      Atom(name: '_HomeContentControllerBase.currentText');

  @override
  int get currentText {
    _$currentTextAtom.reportRead();
    return super.currentText;
  }

  @override
  set currentText(int value) {
    _$currentTextAtom.reportWrite(value, super.currentText, () {
      super.currentText = value;
    });
  }

  final _$textControllerAtom =
      Atom(name: '_HomeContentControllerBase.textController');

  @override
  TextEditingController get textController {
    _$textControllerAtom.reportRead();
    return super.textController;
  }

  @override
  set textController(TextEditingController value) {
    _$textControllerAtom.reportWrite(value, super.textController, () {
      super.textController = value;
    });
  }

  final _$textsAtom = Atom(name: '_HomeContentControllerBase.texts');

  @override
  ObservableFuture<List<HomeTextModel>> get texts {
    _$textsAtom.reportRead();
    return super.texts;
  }

  @override
  set texts(ObservableFuture<List<HomeTextModel>> value) {
    _$textsAtom.reportWrite(value, super.texts, () {
      super.texts = value;
    });
  }

  final _$_HomeContentControllerBaseActionController =
      ActionController(name: '_HomeContentControllerBase');

  @override
  void fetchTexts() {
    final _$actionInfo = _$_HomeContentControllerBaseActionController
        .startAction(name: '_HomeContentControllerBase.fetchTexts');
    try {
      return super.fetchTexts();
    } finally {
      _$_HomeContentControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void likedText(String userName) {
    final _$actionInfo = _$_HomeContentControllerBaseActionController
        .startAction(name: '_HomeContentControllerBase.likedText');
    try {
      return super.likedText(userName);
    } finally {
      _$_HomeContentControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveComment(String username, String comment) {
    final _$actionInfo = _$_HomeContentControllerBaseActionController
        .startAction(name: '_HomeContentControllerBase.saveComment');
    try {
      return super.saveComment(username, comment);
    } finally {
      _$_HomeContentControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage},
currentText: ${currentText},
textController: ${textController},
texts: ${texts}
    ''';
  }
}
