// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileController on _ProfileControllerBase, Store {
  final _$photoUrlAtom = Atom(name: '_ProfileControllerBase.photoUrl');

  @override
  ObservableFuture<ProfileModel> get photoUrl {
    _$photoUrlAtom.reportRead();
    return super.photoUrl;
  }

  @override
  set photoUrl(ObservableFuture<ProfileModel> value) {
    _$photoUrlAtom.reportWrite(value, super.photoUrl, () {
      super.photoUrl = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ProfileControllerBase.loading');

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

  final _$_ProfileControllerBaseActionController =
      ActionController(name: '_ProfileControllerBase');

  @override
  void getPhoto(String userId) {
    final _$actionInfo = _$_ProfileControllerBaseActionController.startAction(
        name: '_ProfileControllerBase.getPhoto');
    try {
      return super.getPhoto(userId);
    } finally {
      _$_ProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
photoUrl: ${photoUrl},
loading: ${loading}
    ''';
  }
}
