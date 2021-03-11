// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discovery_text_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DiscoveryTextController on _DiscoveryTextControllerBase, Store {
  final _$currentPageAtom =
      Atom(name: '_DiscoveryTextControllerBase.currentPage');

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

  final _$textControllerAtom =
      Atom(name: '_DiscoveryTextControllerBase.textController');

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

  final _$textAtom = Atom(name: '_DiscoveryTextControllerBase.text');

  @override
  ObservableFuture<HomeTextModel> get text {
    _$textAtom.reportRead();
    return super.text;
  }

  @override
  set text(ObservableFuture<HomeTextModel> value) {
    _$textAtom.reportWrite(value, super.text, () {
      super.text = value;
    });
  }

  final _$photoUrlAtom = Atom(name: '_DiscoveryTextControllerBase.photoUrl');

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

  final _$loadingAtom = Atom(name: '_DiscoveryTextControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$_DiscoveryTextControllerBaseActionController =
      ActionController(name: '_DiscoveryTextControllerBase');

  @override
  void fetchText(String textId) {
    final _$actionInfo = _$_DiscoveryTextControllerBaseActionController
        .startAction(name: '_DiscoveryTextControllerBase.fetchText');
    try {
      return super.fetchText(textId);
    } finally {
      _$_DiscoveryTextControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void likedText(String userId) {
    final _$actionInfo = _$_DiscoveryTextControllerBaseActionController
        .startAction(name: '_DiscoveryTextControllerBase.likedText');
    try {
      return super.likedText(userId);
    } finally {
      _$_DiscoveryTextControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveComment(String userId, String comment, String userName) {
    final _$actionInfo = _$_DiscoveryTextControllerBaseActionController
        .startAction(name: '_DiscoveryTextControllerBase.saveComment');
    try {
      return super.saveComment(userId, comment, userName);
    } finally {
      _$_DiscoveryTextControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void likedComment(String userId, int index) {
    final _$actionInfo = _$_DiscoveryTextControllerBaseActionController
        .startAction(name: '_DiscoveryTextControllerBase.likedComment');
    try {
      return super.likedComment(userId, index);
    } finally {
      _$_DiscoveryTextControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sharedText(String userId) {
    final _$actionInfo = _$_DiscoveryTextControllerBaseActionController
        .startAction(name: '_DiscoveryTextControllerBase.sharedText');
    try {
      return super.sharedText(userId);
    } finally {
      _$_DiscoveryTextControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage},
textController: ${textController},
text: ${text},
photoUrl: ${photoUrl},
loading: ${loading}
    ''';
  }
}
