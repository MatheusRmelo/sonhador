//import 'package:flutter/cupertino.dart';
part of '../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool loading = false;
  String alignment = 'left';
  int currentPage = 0;
  TextEditingController _controller = TextEditingController(text: '');

  String newTitle = '';
  String status = '';
  Timer _timer;

  String textId = '';

  void changeAlignment(String newAligment) {
    setState(() {
      alignment = newAligment;
    });
  }

  void getText() async {
    await Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> routeData = ModalRoute.of(context).settings.arguments;
    setState(() {
      loading = true;
      textId = '8CGNENASV7yJYO1WJFue';
    });

    Map<dynamic, dynamic> result = await writer.getTextById(textId);
    if (result['error'] != '') {
      print(result['error']);
    } else {
      setState(() {
        _controller.text = writer.text.getPage(currentPage);
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

  void prevPage() {
    setState(() {
      if (currentPage != 0) {
        currentPage--;
      }
      _controller.text = writer.text.getPage(currentPage);
    });
  }

  void nextPage() {
    setState(() {
      if ((currentPage + 1) != writer.text.getPages().length) {
        currentPage++;
        _controller.text = writer.text.getPage(currentPage);
      }
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
    double widthDevice = MediaQuery.of(context).size.width;

    String title = loading ? '' : writer.text.getTitle();

    return Scaffold(
      backgroundColor: Color(0xFF483D3F),
      appBar: loading
          ? LoadingAppBar(pageContext: context, color: Color(0xFF483D3F))
          : HomeAppBar(
              pageContext: context,
              title: status != '' ? '$title - $status' : title,
            ),
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
                            height: heightDevice * 0.65,
                            child: Swiper(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    margin: EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    height: heightDevice * 0.65,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      width: widthDevice * 1,
                                      child: Text(
                                        _controller.text,
                                        style:
                                            TextStyle(fontFamily: 'EBGaramond'),
                                        textAlign: alignment == 'center'
                                            ? TextAlign.center
                                            : alignment == 'left'
                                                ? TextAlign.start
                                                : TextAlign.end,
                                      ),
                                    ));
                              },
                              itemCount: 3,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '#poem',
                              style: smallStyleLight,
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
                            color: Colors.white,
                          ),
                          onPressed: prevPage,
                        ),
                        // IconButton(
                        //   padding: EdgeInsets.zero,
                        //   icon: Icon(Icons.format_align_left,
                        //       size: 32,
                        //       color: alignment == 'left'
                        //           ? Colors.white
                        //           : Colors.black),
                        //   onPressed: () {
                        //     changeAlignment('left');
                        //   },
                        // ),
                        // IconButton(
                        //   padding: EdgeInsets.zero,
                        //   icon: Icon(Icons.format_align_center,
                        //       size: 32,
                        //       color: alignment == 'center'
                        //           ? Colors.white
                        //           : Colors.black),
                        //   onPressed: () {
                        //     changeAlignment('center');
                        //   },
                        // ),
                        // IconButton(
                        //   padding: EdgeInsets.zero,
                        //   icon: Icon(Icons.format_align_right,
                        //       size: 32,
                        //       color: alignment == 'right'
                        //           ? Colors.white
                        //           : Colors.black),
                        //   onPressed: () {
                        //     changeAlignment('right');
                        //   },
                        // ),
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
                            color: Colors.white,
                          ),
                          onPressed: nextPage,
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.person_add,
                              size: 32, color: Colors.white),
                          onPressed: () {
                            changeAlignment('left');
                          },
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.favorite,
                              size: 32, color: Colors.white),
                          onPressed: () {
                            changeAlignment('center');
                          },
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.comment,
                              size: 32, color: Colors.white),
                          onPressed: () {
                            changeAlignment('right');
                          },
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon:
                              Icon(Icons.share, size: 32, color: Colors.white),
                          onPressed: () {
                            changeAlignment('right');
                          },
                        ),
                      ],
                    )),
              ],
            ),
    );
  }
}
