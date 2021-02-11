//import 'package:flutter/cupertino.dart';
part of '../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool loading = false;
  int currentPage = 0;
  int currentText = 0;
  bool liked = false;
  TextEditingController _controller = TextEditingController(text: '');
  String userId = 'matheusRmelo';

  void getTexts() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      loading = true;
    });
    await home.getTexts();
    setState(() {
      _controller.text = home.texts[currentText].getPage(currentPage);
      liked = home.texts[currentText].getLike(userId);
    });
    setState(() {
      loading = false;
    });
  }

  void prevPage() {
    setState(() {
      if (currentPage != 0) {
        currentPage--;
      }
      _controller.text = home.texts[currentText].getPage(currentPage);
    });
  }

  void nextPage() {
    setState(() {
      if ((currentPage + 1) != home.texts[currentText].getPages().length) {
        currentPage++;
        _controller.text = home.texts[currentText].getPage(currentPage);
      }
    });
  }

  void nextText(int index) {
    setState(() {
      if ((index + 1) != home.texts.length) {
        currentText = index;
        _controller.text = home.texts[currentText].getPage(currentPage);
        liked = home.texts[currentText].getLike(userId);
      } else if ((index + 1) <= home.texts.length) {
        currentText = index;
        _controller.text = home.texts[currentText].getPage(currentPage);
        liked = home.texts[currentText].getLike(userId);
      }
    });
  }

  void likedText() async {
    var result = await home.liked(
        home.texts[currentText].getTextId(), userId, currentText);
    if (result['error'] != '') {
      print(result['error']);
    }
    setState(() {
      liked = home.texts[currentText].getLike(userId);
    });
  }

  void sharedText() {
    String text = '';
    text += home.texts[currentText].getTitle() + '\n\n';
    int page = 0;
    home.texts[currentText].getPages().forEach((element) {
      text += (page + 1).toString() +
          '/' +
          home.texts[currentText].getPages().length.toString() +
          '\n\n';
      text += element + '\n\n\n';
      page++;
    });
    text += 'Autor: ' + userId;
    Share.share(text);
  }

  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    getTexts();
  }

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    double widthDevice = MediaQuery.of(context).size.width;

    String title = loading ? '' : home.texts[currentText].getTitle();
    String hashtags = loading ? '' : home.texts[currentText].getHashtags();
    String alignment =
        loading ? 'left' : home.texts[currentText].getAlignment();
    String likes =
        loading ? '0' : home.texts[currentText].getLikes().length.toString();

    return Scaffold(
      backgroundColor: Color(0xFF483D3F),
      appBar: loading
          ? LoadingAppBar(pageContext: context, color: Color(0xFF483D3F))
          : HomeAppBar(
              pageContext: context,
              title: title,
              pagesLength: home.texts[currentText].getPages().length,
              currentPage: currentPage + 1),
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
                              onIndexChanged: (int index) => nextText(index),
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
                              itemCount: loading ? 1 : home.texts.length,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              hashtags,
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
                          onPressed: () {},
                        ),
                        Column(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                liked ? Icons.favorite : Icons.favorite_border,
                                size: 32,
                                color: liked ? Colors.red : Colors.white,
                              ),
                              onPressed: likedText,
                            ),
                            Text(likes, style: smallStyleLight)
                          ],
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.comment,
                              size: 32, color: Colors.white),
                          onPressed: () {
                            Navigator.pushNamed(context, '/comments',
                                arguments: {"currentText": currentText});
                          },
                        ),
                        Text(
                            home.texts[currentText]
                                .getComments()
                                .length
                                .toString(),
                            style: smallStyleLight),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon:
                              Icon(Icons.share, size: 32, color: Colors.white),
                          onPressed: sharedText,
                        ),
                      ],
                    )),
              ],
            ),
    );
  }
}
