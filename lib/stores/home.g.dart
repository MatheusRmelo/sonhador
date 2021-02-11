// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Home on _Home, Store {
  final _$textsAtom = Atom(name: '_Home.texts');

  @override
  List<Text> get texts {
    _$textsAtom.reportRead();
    return super.texts;
  }

  @override
  set texts(List<Text> value) {
    _$textsAtom.reportWrite(value, super.texts, () {
      super.texts = value;
    });
  }

  final _$getTextsAsyncAction = AsyncAction('_Home.getTexts');

  @override
  Future<bool> getTexts() {
    return _$getTextsAsyncAction.run(() => super.getTexts());
  }

  @override
  String toString() {
    return '''
texts: ${texts}
    ''';
  }
}
