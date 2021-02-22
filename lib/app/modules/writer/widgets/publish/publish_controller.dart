import 'package:mobx/mobx.dart';
import 'package:sonhador/app/modules/writer/repository/writer_repository.dart';
part 'publish_controller.g.dart';

class PublishController = _PublishControllerBase with _$PublishController;

abstract class _PublishControllerBase with Store {
  final WriterRepository repository;

  @observable
  bool ads = false;
  @observable
  bool adult = false;
  @observable
  bool published = false;

  _PublishControllerBase(this.repository);

  @action
  void publishText(String id) {
    repository.publishText(id, ads, adult);
  }
}
