//import 'package:flutter/cupertino.dart';
part of '../main.dart';

class WriterPage extends StatefulWidget {
  @override
  _WriterPage createState() => _WriterPage();
}

class _WriterPage extends State<WriterPage> {
  bool loading = false;
  int currentPage = 0;
  TextEditingController _controller = TextEditingController(text: '');
  String newTitle = '';
  String status = '';
  Timer _timer;

  String textId = '';

  void changeAlignment(String newAligment) async {
    writer.text.setAlignment(newAligment);
    setState(() {
      status = 'Salvando...';
    });
    var result = await writer.saveAlignment(textId);

    if (result['data'] == 'success') {
      setState(() {
        status = 'Salvo';
      });
    } else {
      print(result['error']);
      setState(() {
        status = 'Falha ao salvar';
      });
    }
  }

  void getText() async {
    await Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> routeData = ModalRoute.of(context).settings.arguments;
    setState(() {
      loading = true;
      textId = routeData['textId'];
    });

    Map<dynamic, dynamic> result = await writer.getTextById(textId);
    if (result['error'] != '') {
      print(result['error']);
    } else {
      setState(() {
        _controller.text = writer.text.getPages()[currentPage];
      });
    }
    setState(() {
      loading = false;
    });
  }

  void updateText(String textId) async {
    var result = await writer.updatePages(textId);
    if (result['data'] == 'success') {
      setState(() {
        status = 'Salvo';
      });
    } else {
      setState(() {
        status = 'Falha ao salvar';
      });
    }
  }

  void changeTextAction(String text, String textId) {
    writer.text.setPage(text, currentPage);
    setState(() {
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
      }
      _controller.text = writer.text.getPage(currentPage);
    });
    writer.text.cleanUpPages();
  }

  void nextPage() {
    if (writer.text.getPages().length <= currentPage + 1) {
      writer.text.newPage();
    }
    setState(() {
      currentPage++;
      _controller.text = writer.text.getPage(currentPage);
    });
  }

  void saveText(String title) async {
    //await Provider.of<WriterData>(context).saveText(title, pages);
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
                        writer.text.setTitle(title);
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
                    setState(() {
                      status = 'Salvando...';
                    });
                    var result = await writer.updateTitle(textId);
                    if (result['data'] == 'success') {
                      setState(() {
                        status = 'Salvo';
                      });
                    } else {
                      setState(() {
                        status = 'Falha ao salvar';
                      });
                    }
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
      loading = true;
    });
    getText();
  }

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;

    String title = writer.text.getTitle();
    String alignment = writer.text.getAlignment();

    return Scaffold(
      backgroundColor: Color(0xFF9B9987),
      appBar: loading
          ? LoadingAppBar(pageContext: context, color: Color(0xFF9B9987))
          : WriterAppBar(
              pageContext: context,
              title: status != '' ? '$title - $status' : title,
              onChangeTitle: () {
                changeTitle(context, title);
              }),
      body: loading
          ? Loading(status: 'Carregando...')
          : Stack(
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              color: Color(0xFF483D3F),
                              onPressed: () {
                                Navigator.pushNamed(context, '/hashtag',
                                    arguments: {"textId": textId});
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
                          '${currentPage + 1}/${writer.text.getPages().length}',
                          style: smallStyle,
                        )
                      ],
                    )),
              ],
            ),
    );
  }
}
