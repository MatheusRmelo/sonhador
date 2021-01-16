import 'package:flutter/material.dart';

Widget WriterAppBar({@required BuildContext pageContext}) {
  void backAction() {
    Navigator.pop(pageContext);
  }

  void editTitleAction() {
    showDialog(
        context: pageContext,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Edição do título'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Título',
                        icon: Icon(Icons.book),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              RaisedButton(
                  child: Text("Atualizar"),
                  onPressed: () {
                    // your code
                  })
            ],
          );
        });
  }

  return AppBar(
    elevation: 0,
    backgroundColor: Color(0xFFc4c4c4),
    leading: IconButton(
      icon: Icon(Icons.close),
      onPressed: backAction,
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: editTitleAction,
      )
    ],
    title: Text('Writer 2 bar'),
    centerTitle: true,
  );
}
