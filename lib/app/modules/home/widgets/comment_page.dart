import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/modules/home/home_content/home_content_controller.dart';
import 'package:sonhador/app/utils/commentbox.dart';
import 'package:sonhador/app/utils/customappbar.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPage createState() => _CommentPage();
}

class _CommentPage extends State<CommentPage> {
  final homeContentController = Modular.get<HomeContentController>();

  String comment = '';
  TextEditingController _controller = TextEditingController(text: '');
  void saveComment(int currentText) async {
    // if (comment == '') {
    //   print('Digite um comentário');
    // } else {
    //   FocusScope.of(context).unfocus();
    //   _controller.clear();

    //   var result = await home.addComment('matheusRmelo', currentText, comment);
    //   if (result['error'] != '') {
    //     print(result['error']);
    //   }
    //   setState(() {
    //     comment = '';
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    var texts = homeContentController.texts.value;
    return Scaffold(
      backgroundColor: Color(0xFF9B9987),
      appBar: CustomAppBar(pageContext: context, title: 'Comentários'),
      body: Stack(children: [
        Container(
          margin: EdgeInsets.only(bottom: 72),
          child: ListView.builder(
            itemCount: texts[homeContentController.currentText].comments.length,
            itemBuilder: (context, index) => CommentBox(
                userId: texts[homeContentController.currentText].comments[index]
                    ['user_name'],
                comment: texts[homeContentController.currentText]
                    .comments[index]['comment']),
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
                    controller: _controller,
                    onChanged: (text) {
                      setState(() {
                        comment = text;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Digite aqui',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        suffixIcon: TextButton(
                            child: Icon(
                              Icons.send,
                              color: comment == '' ? Colors.grey : Colors.blue,
                            ),
                            onPressed: () {})),
                  ),
                )))
      ]),
    );
  }
}
