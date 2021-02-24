import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:sonhador/app/modules/writer/repository/writer_repository.dart';

import 'model/writer_model.dart';

part 'writer_controller.g.dart';

class WriterController = _WriterBase with _$WriterController;

abstract class _WriterBase with Store {
  final WriterRepository repository;

  @observable
  ObservableFuture<WriterModel> text;

  @observable
  String tmpTitle = '';

  @observable
  int currentPage = 0;

  @observable
  bool loading = false;
  @observable
  bool erro = false;
  @observable
  Timer _timer = Timer(Duration(seconds: 1), () {});
  @observable
  String status = '';
  @observable
  TextEditingController textController = TextEditingController(text: '');

  _WriterBase(this.repository);

  @action
  void createText(String userName) {
    text = repository
        .createNewText(userName, "Sem título", [''], 'left')
        .asObservable();
    //textController.text = text.value.pages[currentPage];
  }

  @action
  void getText(String textId) {
    text = repository.getText(textId).asObservable();
    //textController.text = text.value.pages[currentPage];
  }

  @action
  void editPage(String page) {
    text.value.editPage(page, currentPage);
    if (_timer.isActive) {
      _timer.cancel();
    }
    _timer = Timer(Duration(seconds: 1), () {
      repository.editPages(text.value.id, text.value.pages).then((value) {
        this.status = 'Salvo';
      }).catchError((err) {
        this.status = 'Erro ao salvar!';
      });
    });
  }

  @action
  void changeAligment(String alignment) {
    text.value.alignment = alignment;
    repository
        .changeAlignment(text.value.id, text.value.alignment)
        .then((value) {
      this.status = 'Salvo';
    }).catchError((err) {
      this.status = 'Erro ao salvar!';
    });
  }

  @action
  void changeTitle() {
    text.value.title = tmpTitle;
    repository.changeTitle(text.value.id, text.value.title).then((value) {
      this.status = 'Salvo';
    }).catchError((err) {
      this.status = 'Erro ao salvar!';
    });
  }

  @action
  void nextPage() {
    if (text.value.pages.length <= currentPage + 1) {
      text.value.addPage();
      repository.editPages(text.value.id, text.value.pages).then((value) {
        this.status = 'Salvo';
      }).catchError((err) {
        this.status = 'Erro ao salvar!';
      });
    }
    this.status = 'Salvo';
    this.currentPage++;
    this.textController.text = text.value.pages[currentPage];
    final val = TextSelection.collapsed(offset: textController.text.length);
    textController.selection = val;
  }

  @action
  void prevPage() {
    text.value.cleanUpPages();
    repository.editPages(text.value.id, text.value.pages).then((value) {
      this.status = 'Salvo';
    }).catchError((err) {
      this.status = 'Erro ao salvar!';
    });

    if (currentPage != 0) {
      this.currentPage--;
    }
    this.textController.text = text.value.pages[currentPage];
    final val = TextSelection.collapsed(offset: textController.text.length);
    textController.selection = val;
  }
}
