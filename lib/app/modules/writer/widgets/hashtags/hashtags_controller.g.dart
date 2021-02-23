// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hashtags_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HashTagsController on _HashTagsControllerBase, Store {
  final _$textControllerAtom =
      Atom(name: '_HashTagsControllerBase.textController');

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

  final _$tagsAtom = Atom(name: '_HashTagsControllerBase.tags');

  @override
  String get tags {
    _$tagsAtom.reportRead();
    return super.tags;
  }

  @override
  set tags(String value) {
    _$tagsAtom.reportWrite(value, super.tags, () {
      super.tags = value;
    });
  }

  final _$loadingAtom = Atom(name: '_HashTagsControllerBase.loading');

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

  final _$getHashtagsAsyncAction =
      AsyncAction('_HashTagsControllerBase.getHashtags');

  @override
  Future<String> getHashtags(String id) {
    return _$getHashtagsAsyncAction.run(() => super.getHashtags(id));
  }

  final _$_HashTagsControllerBaseActionController =
      ActionController(name: '_HashTagsControllerBase');

  @override
  void saveHashtags(String id) {
    final _$actionInfo = _$_HashTagsControllerBaseActionController.startAction(
        name: '_HashTagsControllerBase.saveHashtags');
    try {
      return super.saveHashtags(id);
    } finally {
      _$_HashTagsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
textController: ${textController},
tags: ${tags},
loading: ${loading}
    ''';
  }
}
