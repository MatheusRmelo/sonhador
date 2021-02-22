// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publish_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PublishController on _PublishControllerBase, Store {
  final _$adsAtom = Atom(name: '_PublishControllerBase.ads');

  @override
  bool get ads {
    _$adsAtom.reportRead();
    return super.ads;
  }

  @override
  set ads(bool value) {
    _$adsAtom.reportWrite(value, super.ads, () {
      super.ads = value;
    });
  }

  final _$adultAtom = Atom(name: '_PublishControllerBase.adult');

  @override
  bool get adult {
    _$adultAtom.reportRead();
    return super.adult;
  }

  @override
  set adult(bool value) {
    _$adultAtom.reportWrite(value, super.adult, () {
      super.adult = value;
    });
  }

  final _$publishedAtom = Atom(name: '_PublishControllerBase.published');

  @override
  bool get published {
    _$publishedAtom.reportRead();
    return super.published;
  }

  @override
  set published(bool value) {
    _$publishedAtom.reportWrite(value, super.published, () {
      super.published = value;
    });
  }

  final _$_PublishControllerBaseActionController =
      ActionController(name: '_PublishControllerBase');

  @override
  void publishText(String id) {
    final _$actionInfo = _$_PublishControllerBaseActionController.startAction(
        name: '_PublishControllerBase.publishText');
    try {
      return super.publishText(id);
    } finally {
      _$_PublishControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ads: ${ads},
adult: ${adult},
published: ${published}
    ''';
  }
}
