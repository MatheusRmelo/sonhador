import 'package:mobx/mobx.dart';
part 'input_controller.g.dart';

class InputController = _InputControllerBase with _$InputController;

abstract class _InputControllerBase with Store {
  @observable
  String text;
}
