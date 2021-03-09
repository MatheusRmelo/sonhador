// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeProfileController on _HomeProfileControllerBase, Store {
  final _$userAtom = Atom(name: '_HomeProfileControllerBase.user');

  @override
  ObservableFuture<UserModel> get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(ObservableFuture<UserModel> value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$photoUrlAtom = Atom(name: '_HomeProfileControllerBase.photoUrl');

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

  final _$loadingAtom = Atom(name: '_HomeProfileControllerBase.loading');

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

  final _$_HomeProfileControllerBaseActionController =
      ActionController(name: '_HomeProfileControllerBase');

  @override
  void getUser(String userId) {
    final _$actionInfo = _$_HomeProfileControllerBaseActionController
        .startAction(name: '_HomeProfileControllerBase.getUser');
    try {
      return super.getUser(userId);
    } finally {
      _$_HomeProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getPhoto(String userId) {
    final _$actionInfo = _$_HomeProfileControllerBaseActionController
        .startAction(name: '_HomeProfileControllerBase.getPhoto');
    try {
      return super.getPhoto(userId);
    } finally {
      _$_HomeProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void newFollow(String userId) {
    final _$actionInfo = _$_HomeProfileControllerBaseActionController
        .startAction(name: '_HomeProfileControllerBase.newFollow');
    try {
      return super.newFollow(userId);
    } finally {
      _$_HomeProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void unfollow() {
    final _$actionInfo = _$_HomeProfileControllerBaseActionController
        .startAction(name: '_HomeProfileControllerBase.unfollow');
    try {
      return super.unfollow();
    } finally {
      _$_HomeProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
photoUrl: ${photoUrl},
loading: ${loading}
    ''';
  }
}
