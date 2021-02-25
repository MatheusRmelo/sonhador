import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/writer/writer_controller.dart';
import 'package:sonhador/app/utils/fonts.dart';
import 'package:sonhador/app/widgets/loading.dart';
import 'package:sonhador/app/widgets/writerappbar.dart';

import 'model/writer_model.dart';

class WriterPage extends StatefulWidget {
  @override
  _WriterPage createState() => _WriterPage();
}

class _WriterPage extends State<WriterPage> {
  final writerController = Modular.get<WriterController>();
  final appController = Modular.get<AppController>();
  //TextEditingController _textController = TextEditingController(text: '');

  void getText() async {
    await Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> routeData = ModalRoute.of(context).settings.arguments;
    bool newText = routeData['newText'];
    if (newText) {
      writerController.createText(appController.user.value.userName);
      writerController.loading = false;
    } else {
      String textId = routeData['textId'];
      writerController.getText(textId);
      writerController.loading = false;
    }
  }

  void editText(String value) {
    writerController.status = 'Salvando...';
    writerController.editPage(value);
  }

  void changeAlignment(String alignment) {
    writerController.status = 'Salvando...';
    writerController.changeAligment(alignment);
  }

  void prevPage() {
    writerController.status = 'Salvando...';
    writerController.prevPage();
    //_textController.text =writerController.text.value.pages[writerController.currentPage];
  }

  void nextPage() {
    writerController.status = 'Salvando...';
    writerController.nextPage();
    //_textController.text =writerController.text.value.pages[writerController.currentPage];
  }

  void initState() {
    super.initState();
    writerController.loading = true;
    getText();
  }

  void changeTitle(BuildContext pageContext, String title) {
    showDialog(
        context: pageContext,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Padding(
              padding: const EdgeInsets.all(4),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      initialValue: title,
                      decoration: InputDecoration(
                        labelText: 'Título',
                        icon: Icon(Icons.book),
                      ),
                      onChanged: (title) {
                        writerController.tmpTitle = title;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              RaisedButton(
                  child: Text("Atualizar"),
                  onPressed: () {
                    writerController.changeTitle();
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (writerController.loading) {
        return Loading(status: 'Carregando...');
      }
      if (writerController.text.value == null) {
        return Loading(status: 'Carregando...');
      }
      if (writerController.text.error != null) {
        return Center(
          child: Column(
            children: [
              Text('Ocorreu um erro, tente novamente mais tarde'),
              RaisedButton(
                onPressed: () {},
                child: Text('Recarregar'),
              )
            ],
          ),
        );
      }

      double heightDevice = MediaQuery.of(context).size.height;
      WriterModel text = writerController.text.value;
      if (writerController.textController.text == '') {
        writerController.textController.text =
            writerController.text.value.pages[writerController.currentPage];
      }
      //_textController.text = text.pages[writerController.currentPage];
      return Scaffold(
          backgroundColor: Color(0xFF9B9987),
          appBar: WriterAppBar(
              pageContext: context,
              title: writerController.status != ''
                  ? '${text.title} - ${writerController.status}'
                  : text.title,
              onChangeTitle: () {
                changeTitle(context, text.title);
              }),
          body: Stack(
            children: [
              Positioned(
                  left: 56,
                  right: 56,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        height: heightDevice * 0.7,
                        child: TextFormField(
                          autofocus: true,
                          style: TextStyle(fontFamily: 'EBGaramond'),
                          controller: writerController.textController,
                          textAlignVertical: TextAlignVertical.top,
                          textAlign: text.alignment == 'center'
                              ? TextAlign.center
                              : text.alignment == 'left'
                                  ? TextAlign.start
                                  : TextAlign.end,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (value) {
                            editText(value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Começe a escrever',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Color(0xFF483D3F),
                            onPressed: () {
                              Modular.to.pushNamed('/writer/hashtag',
                                  arguments: {"textId": text.id});
                            },
                            child: Text(
                              'Avançar',
                              style: smallStyleLight,
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              Positioned(
                  left: 0,
                  top: 64,
                  child: Column(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          size: 40,
                        ),
                        onPressed: prevPage,
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.format_align_left,
                            size: 32,
                            color: text.alignment == 'left'
                                ? Colors.white
                                : Colors.black),
                        onPressed: () {
                          changeAlignment('left');
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.format_align_center,
                            size: 32,
                            color: text.alignment == 'center'
                                ? Colors.white
                                : Colors.black),
                        onPressed: () {
                          changeAlignment('center');
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.format_align_right,
                            size: 32,
                            color: text.alignment == 'right'
                                ? Colors.white
                                : Colors.black),
                        onPressed: () {
                          changeAlignment('right');
                        },
                      ),
                    ],
                  )),
              Positioned(
                  right: 0,
                  top: 64,
                  child: Column(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          size: 40,
                        ),
                        onPressed: nextPage,
                      ),
                      Text(
                        '${writerController.currentPage + 1}/${text.pages.length}',
                        style: smallStyle,
                      )
                    ],
                  )),
            ],
          ));
    });
  }
}
