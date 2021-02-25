import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sonhador/app/modules/home/home_content/model/home_text_model.dart';

class HomeTextRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<HomeTextModel>> getTexts() async {
    List<HomeTextModel> texts = [];

    QuerySnapshot result = await db
        .collection('texts')
        .where('published', isEqualTo: true)
        .limit(35)
        .get();

    result.docs.forEach((element) async {
      var data = element.data();

      HomeTextModel text = HomeTextModel(
          id: element.id,
          alignment: data['alignment'],
          likes: data['likes'],
          pages: data['pages'],
          title: data['title'],
          comments: data['comments'],
          hashtags: data['hashtags'],
          userName: data['userId']);
      texts.add(text);
    });

    return texts;
  }

  void likedText(HomeTextModel text) async {
    await db.collection('texts').doc(text.id).update({"likes": text.likes});
  }
}
