// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'writer.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Writer on _Writer, Store {
  final _$myTextsAtom = Atom(name: '_Writer.myTexts');

  @override
  List<Map<dynamic, dynamic>> get myTexts {
    _$myTextsAtom.reportRead();
    return super.myTexts;
  }

  @override
  set myTexts(List<Map<dynamic, dynamic>> value) {
    _$myTextsAtom.reportWrite(value, super.myTexts, () {
      super.myTexts = value;
    });
  }

  final _$textAtom = Atom(name: '_Writer.text');

  @override
  Text get text {
    _$textAtom.reportRead();
    return super.text;
  }

  @override
  set text(Text value) {
    _$textAtom.reportWrite(value, super.text, () {
      super.text = value;
    });
  }

  final _$createTextAsyncAction = AsyncAction('_Writer.createText');

  @override
  Future<Map<dynamic, dynamic>> createText(
      {String userId, String newTitle = 'Sem título'}) {
    return _$createTextAsyncAction
        .run(() => super.createText(userId: userId, newTitle: newTitle));
  }

  @override
  String toString() {
    return '''
myTexts: ${myTexts},
text: ${text}
    ''';
  }
}
