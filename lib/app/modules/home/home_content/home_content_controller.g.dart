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

  final _$photoUrlAtom = Atom(name: '_HomeContentControllerBase.photoUrl');

  @override
  ObservableFuture<String> get photoUrl {
    _$photoUrlAtom.reportRead();
    return super.photoUrl;
  }

  @override
  set photoUrl(ObservableFuture<String> value) {
    _$photoUrlAtom.reportWrite(value, super.photoUrl, () {
      super.photoUrl = value;
    });
  }

  final _$nextTextsAtom = Atom(name: '_HomeContentControllerBase.nextTexts');

  @override
  ObservableFuture<List<HomeTextModel>> get nextTexts {
    _$nextTextsAtom.reportRead();
    return super.nextTexts;
  }

  @override
  set nextTexts(ObservableFuture<List<HomeTextModel>> value) {
    _$nextTextsAtom.reportWrite(value, super.nextTexts, () {
      super.nextTexts = value;
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
  void fetchMoreTexts(String lastId) {
    final _$actionInfo = _$_HomeContentControllerBaseActionController
        .startAction(name: '_HomeContentControllerBase.fetchMoreTexts');
    try {
      return super.fetchMoreTexts(lastId);
    } finally {
      _$_HomeContentControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getMoreTexts() {
    final _$actionInfo = _$_HomeContentControllerBaseActionController
        .startAction(name: '_HomeContentControllerBase.getMoreTexts');
    try {
      return super.getMoreTexts();
    } finally {
      _$_HomeContentControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void likedText(String userId) {
    final _$actionInfo = _$_HomeContentControllerBaseActionController
        .startAction(name: '_HomeContentControllerBase.likedText');
    try {
      return super.likedText(userId);
    } finally {
      _$_HomeContentControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveComment(String userId, String comment, String userName) {
    final _$actionInfo = _$_HomeContentControllerBaseActionController
        .startAction(name: '_HomeContentControllerBase.saveComment');
    try {
      return super.saveComment(userId, comment, userName);
    } finally {
      _$_HomeContentControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void likedComment(String userId, int index) {
    final _$actionInfo = _$_HomeContentControllerBaseActionController
        .startAction(name: '_HomeContentControllerBase.likedComment');
    try {
      return super.likedComment(userId, index);
    } finally {
      _$_HomeContentControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sharedText(String userId) {
    final _$actionInfo = _$_HomeContentControllerBaseActionController
        .startAction(name: '_HomeContentControllerBase.sharedText');
    try {
      return super.sharedText(userId);
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
texts: ${texts},
photoUrl: ${photoUrl},
nextTexts: ${nextTexts}
    ''';
  }
}
