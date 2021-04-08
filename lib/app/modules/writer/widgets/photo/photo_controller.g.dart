// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PhotoController on _PhotoControllerBase, Store {
  final _$photoAtom = Atom(name: '_PhotoControllerBase.photo');

  @override
  ObservableFuture<PhotoModel> get photo {
    _$photoAtom.reportRead();
    return super.photo;
  }

  @override
  set photo(ObservableFuture<PhotoModel> value) {
    _$photoAtom.reportWrite(value, super.photo, () {
      super.photo = value;
    });
  }

  final _$loadingAtom = Atom(name: '_PhotoControllerBase.loading');

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

  final _$savePhotoAsyncAction = AsyncAction('_PhotoControllerBase.savePhoto');

  @override
  Future<bool> savePhoto(File file, String textId) {
    return _$savePhotoAsyncAction.run(() => super.savePhoto(file, textId));
  }

  final _$_PhotoControllerBaseActionController =
      ActionController(name: '_PhotoControllerBase');

  @override
  void getPhoto(String textId) {
    final _$actionInfo = _$_PhotoControllerBaseActionController.startAction(
        name: '_PhotoControllerBase.getPhoto');
    try {
      return super.getPhoto(textId);
    } finally {
      _$_PhotoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
photo: ${photo},
loading: ${loading}
    ''';
  }
}
