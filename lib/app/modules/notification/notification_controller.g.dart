// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationController on _NotificationControllerBase, Store {
  final _$notificationsAtom =
      Atom(name: '_NotificationControllerBase.notifications');

  @override
  ObservableFuture<List<NotificationModel>> get notifications {
    _$notificationsAtom.reportRead();
    return super.notifications;
  }

  @override
  set notifications(ObservableFuture<List<NotificationModel>> value) {
    _$notificationsAtom.reportWrite(value, super.notifications, () {
      super.notifications = value;
    });
  }

  final _$_NotificationControllerBaseActionController =
      ActionController(name: '_NotificationControllerBase');

  @override
  void fetchNotifications() {
    final _$actionInfo = _$_NotificationControllerBaseActionController
        .startAction(name: '_NotificationControllerBase.fetchNotifications');
    try {
      return super.fetchNotifications();
    } finally {
      _$_NotificationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notifications: ${notifications}
    ''';
  }
}
