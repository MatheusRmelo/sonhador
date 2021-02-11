part of '../main.dart';

class CommentsPage extends StatefulWidget {
  @override
  _CommentsPage createState() => _CommentsPage();
}

class _CommentsPage extends State<CommentsPage> {
  String comment = '';
  TextEditingController _controller = TextEditingController(text: '');
  void saveComment(int currentText) async {
    if (comment == '') {
      print('Digite um comentário');
    } else {
      FocusScope.of(context).unfocus();
      _controller.clear();

      var result = await home.addComment('matheusRmelo', currentText, comment);
      if (result['error'] != '') {
        print(result['error']);
      }
      setState(() {
        comment = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    Map<String, dynamic> routeData = ModalRoute.of(context).settings.arguments;
    int currentText = routeData['currentText'];

    return Scaffold(
      backgroundColor: Color(0xFF9B9987),
      appBar: CustomAppBar(pageContext: context, title: 'Comentários'),
      body: Stack(children: [
        Container(
          margin: EdgeInsets.only(bottom: 72),
          child: ListView.builder(
            itemCount: home.texts[currentText].getComments().length,
            itemBuilder: (context, index) => CommentBox(
                userId: home.texts[currentText].getComment(index)['userId'],
                comment: home.texts[currentText].getComment(index)['comment']),
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
                            onPressed: () => saveComment(currentText))),
                  ),
                )))
      ]),
    );
  }
}
