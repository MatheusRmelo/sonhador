import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../partials/writerappbar.dart';
import '../models/writerdata.dart';

class WriterPage extends StatefulWidget {
  @override
  _WriterPage createState() => _WriterPage();
}

class _WriterPage extends State<WriterPage> {
  String alignment = 'left';
  List<String> pages = [''];
  int currentPage = 0;
  TextEditingController _controller = TextEditingController(text: '');
  TextStyle smallStyle = TextStyle(fontFamily: 'Fredoka One', fontSize: 12);
  TextStyle smallStyleLight =
      TextStyle(fontFamily: 'Fredoka One', fontSize: 12, color: Colors.white);

  String newTitle = '';
  String status = '';
  Timer _timer;

  void changeAlignment(@required String newAligment) {
    setState(() {
      alignment = newAligment;
    });
  }

  void updateText(String textId) async {
    await Provider.of<WriterData>(context).updatePages(pages, textId);
    setState(() {
      status = 'Salvo';
    });
  }

  void changeTextAction(String text, String textId) {
    setState(() {
      pages[currentPage] = text;
      status = 'Salvando...';
      if (_timer.isActive) {
        _timer.cancel();
      }
      _timer = Timer(Duration(seconds: 1), () {
        updateText(textId);
      });
    });
  }

  void prevPage() {
    setState(() {
      if (currentPage != 0) {
        currentPage--;
        pages.remove('');
      }
    });
    _controller.text = pages[currentPage];
  }

  void nextPage() {
    setState(() {
      if (pages.length <= currentPage + 1) {
        pages.add('');
      }
      currentPage++;
    });
    _controller.text = pages[currentPage];
  }

  void saveText(String title) async {
    await Provider.of<WriterData>(context).saveText(title, pages);
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
                        setState(() {
                          newTitle = title;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              RaisedButton(
                  child: Text("Atualizar"),
                  onPressed: () async {
                    await Provider.of<WriterData>(context).setTitle(newTitle);
                    setState(() {
                      newTitle = '';
                    });
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  void initState() {
    super.initState();
    setState(() {
      _timer = Timer(Duration(seconds: 1), () {});
    });
    //Provider.of<WriterData>(context).saveText('Sem título', pages);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> routeData = ModalRoute.of(context).settings.arguments;
    String textId = routeData['textId'];
    double heightDevice = MediaQuery.of(context).size.height;
    String title = Provider.of<WriterData>(context).title;

    return Consumer<WriterData>(
        builder: (ctx, writerdata, child) => Scaffold(
              backgroundColor: Color(0xFF9B9987),
              appBar: WriterAppBar(
                  pageContext: context,
                  title: status != '' ? '$title - $status' : title,
                  onChangeTitle: () {
                    changeTitle(context, title);
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
                              style: TextStyle(fontFamily: 'EBGaramond'),
                              autofocus: true,
                              controller: _controller,
                              textAlignVertical: TextAlignVertical.top,
                              textAlign: alignment == 'center'
                                  ? TextAlign.center
                                  : alignment == 'left'
                                      ? TextAlign.start
                                      : TextAlign.end,
                              expands: true,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              onChanged: (text) {
                                changeTextAction(text, textId);
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
                                color: Color(0xFF483D3F),
                                onPressed: () {
                                  saveText(title);
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
                                color: alignment == 'left'
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
                                color: alignment == 'center'
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
                                color: alignment == 'right'
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
                            '${currentPage + 1}/${pages.length}',
                            style: smallStyle,
                          )
                        ],
                      )),
                ],
              ),
            ));
  }
}
