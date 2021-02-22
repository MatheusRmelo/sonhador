import 'package:mobx/mobx.dart';
import 'package:sonhador/app/modules/writer/repository/writer_repository.dart';
import '../../model/text_model.dart';
part 'search_controller.g.dart';

class SearchController = _SearchControllerBase with _$SearchController;

abstract class _SearchControllerBase with Store {
  final WriterRepository repository;

  @observable
  ObservableFuture<List<TextModel>> textsList;
  @observable
  List<TextModel> texts;

  _SearchControllerBase(this.repository) {
    fetchTexts('matheusRmelo');
  }

  @action
  void fetchTexts(String userId) {
    textsList = repository.getAllTexts(userId).asObservable();
    texts = textsList.value;
  }

  @action
  void searchText(String textSearch) {
    textSearch = textSearch.trim().toLowerCase();
    // List<TextModel> results = [];
    // if (textSearch == '') {
    //   texts = textsList.value;
    // } else {
    //   for (var text in texts) {
    //     if (text.title.toLowerCase().contains(textSearch)) {
    //       results.add(text);
    //     }
    //   }
    //   texts = results;
    // }
  }
}
