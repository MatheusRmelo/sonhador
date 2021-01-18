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
  String newTitle = '';

  void changeAlignment(@required String newAligment) {
    setState(() {
      alignment = newAligment;
    });
  }

  void changeTextAction(String text) {
    setState(() {
      pages[currentPage] = text;
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

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    String title = Provider.of<WriterData>(context).title;

    return Consumer<WriterData>(
        builder: (ctx, writerdata, child) => Scaffold(
              backgroundColor: Color(0xFF9B9987),
              appBar: WriterAppBar(
                  pageContext: context,
                  title: title,
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
                                changeTextAction(text);
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.check),
                                  Text('Rascunho salvo')
                                ],
                              ),
                              RaisedButton(
                                onPressed: () {
                                  saveText(title);
                                },
                                child: Text(
                                  'Avançar',
                                  style: smallStyle,
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
