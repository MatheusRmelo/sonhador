// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'writer_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WriterController on _WriterBase, Store {
  final _$textAtom = Atom(name: '_WriterBase.text');

  @override
  ObservableFuture<WriterModel> get text {
    _$textAtom.reportRead();
    return super.text;
  }

  @override
  set text(ObservableFuture<WriterModel> value) {
    _$textAtom.reportWrite(value, super.text, () {
      super.text = value;
    });
  }

  final _$tmpTitleAtom = Atom(name: '_WriterBase.tmpTitle');

  @override
  String get tmpTitle {
    _$tmpTitleAtom.reportRead();
    return super.tmpTitle;
  }

  @override
  set tmpTitle(String value) {
    _$tmpTitleAtom.reportWrite(value, super.tmpTitle, () {
      super.tmpTitle = value;
    });
  }

  final _$currentPageAtom = Atom(name: '_WriterBase.currentPage');

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

  final _$loadingAtom = Atom(name: '_WriterBase.loading');

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

  final _$erroAtom = Atom(name: '_WriterBase.erro');

  @override
  bool get erro {
    _$erroAtom.reportRead();
    return super.erro;
  }

  @override
  set erro(bool value) {
    _$erroAtom.reportWrite(value, super.erro, () {
      super.erro = value;
    });
  }

  final _$_timerAtom = Atom(name: '_WriterBase._timer');

  @override
  Timer get _timer {
    _$_timerAtom.reportRead();
    return super._timer;
  }

  @override
  set _timer(Timer value) {
    _$_timerAtom.reportWrite(value, super._timer, () {
      super._timer = value;
    });
  }

  final _$statusAtom = Atom(name: '_WriterBase.status');

  @override
  String get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$textControllerAtom = Atom(name: '_WriterBase.textController');

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

  final _$_WriterBaseActionController = ActionController(name: '_WriterBase');

  @override
  void createText(String userName) {
    final _$actionInfo = _$_WriterBaseActionController.startAction(
        name: '_WriterBase.createText');
    try {
      return super.createText(userName);
    } finally {
      _$_WriterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getText(String textId) {
    final _$actionInfo =
        _$_WriterBaseActionController.startAction(name: '_WriterBase.getText');
    try {
      return super.getText(textId);
    } finally {
      _$_WriterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editPage(String page) {
    final _$actionInfo =
        _$_WriterBaseActionController.startAction(name: '_WriterBase.editPage');
    try {
      return super.editPage(page);
    } finally {
      _$_WriterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeAligment(String alignment) {
    final _$actionInfo = _$_WriterBaseActionController.startAction(
        name: '_WriterBase.changeAligment');
    try {
      return super.changeAligment(alignment);
    } finally {
      _$_WriterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTitle() {
    final _$actionInfo = _$_WriterBaseActionController.startAction(
        name: '_WriterBase.changeTitle');
    try {
      return super.changeTitle();
    } finally {
      _$_WriterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextPage() {
    final _$actionInfo =
        _$_WriterBaseActionController.startAction(name: '_WriterBase.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_WriterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void prevPage() {
    final _$actionInfo =
        _$_WriterBaseActionController.startAction(name: '_WriterBase.prevPage');
    try {
      return super.prevPage();
    } finally {
      _$_WriterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
text: ${text},
tmpTitle: ${tmpTitle},
currentPage: ${currentPage},
loading: ${loading},
erro: ${erro},
status: ${status},
textController: ${textController}
    ''';
  }
}
