// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CommentController on _CommentControllerBase, Store {
  final _$commentAtom = Atom(name: '_CommentControllerBase.comment');

  @override
  String get comment {
    _$commentAtom.reportRead();
    return super.comment;
  }

  @override
  set comment(String value) {
    _$commentAtom.reportWrite(value, super.comment, () {
      super.comment = value;
    });
  }

  @override
  String toString() {
    return '''
comment: ${comment}
    ''';
  }
}
