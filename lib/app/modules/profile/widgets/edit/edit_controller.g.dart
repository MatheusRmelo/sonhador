// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditController on _EditControllerBase, Store {
  final _$userNameControllerAtom =
      Atom(name: '_EditControllerBase.userNameController');

  @override
  TextEditingController get userNameController {
    _$userNameControllerAtom.reportRead();
    return super.userNameController;
  }

  @override
  set userNameController(TextEditingController value) {
    _$userNameControllerAtom.reportWrite(value, super.userNameController, () {
      super.userNameController = value;
    });
  }

  final _$userDisplayControllerAtom =
      Atom(name: '_EditControllerBase.userDisplayController');

  @override
  TextEditingController get userDisplayController {
    _$userDisplayControllerAtom.reportRead();
    return super.userDisplayController;
  }

  @override
  set userDisplayController(TextEditingController value) {
    _$userDisplayControllerAtom.reportWrite(value, super.userDisplayController,
        () {
      super.userDisplayController = value;
    });
  }

  final _$_EditControllerBaseActionController =
      ActionController(name: '_EditControllerBase');

  @override
  void saveImage(File file, String userId) {
    final _$actionInfo = _$_EditControllerBaseActionController.startAction(
        name: '_EditControllerBase.saveImage');
    try {
      return super.saveImage(file, userId);
    } finally {
      _$_EditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userNameController: ${userNameController},
userDisplayController: ${userDisplayController}
    ''';
  }
}
