import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../repository/profile_repository.dart';
part 'edit_controller.g.dart';

class EditController = _EditControllerBase with _$EditController;

abstract class _EditControllerBase with Store {
  final ProfileRepository repository;

  _EditControllerBase(this.repository);

  @observable
  TextEditingController userNameController = TextEditingController(text: '');
  @observable
  TextEditingController userDisplayController = TextEditingController(text: '');

  @action
  Future<bool> saveImage(File file, String userId) {
    return repository.uploadFile(file, userId);
  }
}
