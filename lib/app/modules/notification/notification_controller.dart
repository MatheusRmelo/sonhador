import 'package:mobx/mobx.dart';
import 'package:sonhador/app/modules/notification/model/notification_model.dart';
import 'package:sonhador/app/modules/notification/repository/notification_repository.dart';
part 'notification_controller.g.dart';

class NotificationController = _NotificationControllerBase
    with _$NotificationController;

abstract class _NotificationControllerBase with Store {
  final NotificationRepository repository;

  @observable
  ObservableFuture<NotificationModel> notifications;

  _NotificationControllerBase(this.repository);
}
