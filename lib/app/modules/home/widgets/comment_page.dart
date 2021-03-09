import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/home/home_content/home_content_controller.dart';
import 'package:sonhador/app/modules/home/home_content/model/home_text_model.dart';
import 'package:sonhador/app/modules/home/widgets/comment_controller.dart';
import 'package:sonhador/app/widgets/commentbox.dart';
import 'package:sonhador/app/widgets/customappbar.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPage createState() => _CommentPage();
}

class _CommentPage extends State<CommentPage> {
  final homeContentController = Modular.get<HomeContentController>();
  final commentController = Modular.get<CommentController>();
  final appController = Modular.get<AppController>();

  void saveComment() {
    homeContentController.saveComment(appController.user.value.userId,
        commentController.comment, appController.user.value.userName);
    commentController.textController.clear();
    commentController.comment = '';
    FocusScope.of(context).unfocus();
  }

  void likedComment(int index) {
    homeContentController.likedComment(appController.user.value.userId, index);
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    //var texts = homeContentController.texts.value;
    Map<String, dynamic> routeData = ModalRoute.of(context).settings.arguments;
    HomeTextModel text = routeData['text'];

    return Observer(builder: (_) {
      return Scaffold(
        backgroundColor: Color(0xFF9B9987),
        appBar: CustomAppBar(pageContext: context, title: 'Comentários'),
        body: Stack(children: [
          Container(
            margin: EdgeInsets.only(bottom: 72),
            child: ListView.builder(
              itemCount: text.comments.length,
              itemBuilder: (context, index) => CommentBox(
                userId: text.comments[index]['user_name'],
                comment: text.comments[index]['comment'],
                liked: text.comments[index]['likes']
                    .contains(appController.user.value.userId),
                index: index,
                handleClickLiked: (int index) {
                  likedComment(index);
                },
                commentsNumber: text.comments[index]['likes'].length.toString(),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  padding: EdgeInsets.all(8),
                  width: widthDevice,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: TextField(
                      controller: commentController.textController,
                      onChanged: (text) {
                        commentController.comment = text;
                      },
                      decoration: InputDecoration(
                          hintText: 'Digite aqui',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          suffixIcon: TextButton(
                              child: Icon(
                                Icons.send,
                                color: commentController.comment == ''
                                    ? Colors.grey
                                    : Colors.blue,
                              ),
                              onPressed: () {
                                saveComment();
                              })),
                    ),
                  )))
        ]),
      );
    });
  }
}
