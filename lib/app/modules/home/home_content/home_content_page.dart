import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:share/share.dart';
import 'package:sonhador/app/modules/home/home_content/home_content_controller.dart';
import 'package:sonhador/app/modules/home/home_content/model/home_text_model.dart';
import 'package:sonhador/app/utils/fonts.dart';
import 'package:sonhador/app/utils/loading.dart';
import 'package:sonhador/partials/homeappbar.dart';

class HomeContentPage extends StatefulWidget {
  @override
  _HomeContentPage createState() => _HomeContentPage();
}

class _HomeContentPage extends State<HomeContentPage> {
  final homeController = Modular.get<HomeContentController>();

  void prevPage() {
    // setState(() {
    //   if (currentPage != 0) {
    //     currentPage--;
    //   }
    //   //_controller.text = home.texts[currentText].getPage(currentPage);
    // });
  }

  void nextPage() {
    // setState(() {
    //   if ((currentPage + 1) != home.texts[currentText].getPages().length) {
    //     currentPage++;
    //     _controller.text = home.texts[currentText].getPage(currentPage);
    //   }
    // });
  }

  void nextText(int index) {
    setState(() {
      // if ((index + 1) != home.texts.length) {
      //   currentText = index;
      //   _controller.text = home.texts[currentText].getPage(currentPage);
      //   liked = home.texts[currentText].getLike(userId);
      // } else if ((index + 1) <= home.texts.length) {
      //   currentText = index;
      //   _controller.text = home.texts[currentText].getPage(currentPage);
      //   liked = home.texts[currentText].getLike(userId);
      // }
    });
  }

  void likedText() async {
    // var result = await home.liked(
    //     home.texts[currentText].getTextId(), userId, currentText);
    // if (result['error'] != '') {
    //   print(result['error']);
    // }
    // setState(() {
    //   liked = home.texts[currentText].getLike(userId);
    // });
  }

  void sharedText(HomeTextModel text) {
    String textShared = '';
    textShared += text.title + '\n\n';
    int page = 0;
    text.pages.forEach((element) {
      textShared +=
          (page + 1).toString() + '/' + text.pages.length.toString() + '\n\n';
      textShared += element + '\n\n\n';
      page++;
    });
    textShared += 'Autor: ' + text.userName;
    Share.share(textShared);
  }

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    double widthDevice = MediaQuery.of(context).size.width;

    return Observer(builder: (_) {
      if (homeController.texts.value == null) {
        return Loading(
          status: 'Carregando...',
          color: Color(0xFF483D3F),
        );
      }

      var text = homeController.texts.value[homeController.currentText];
      homeController.textController.text =
          text.pages[homeController.currentPage];
      String hashtags = '';
      text.hashtags.forEach((element) {
        hashtags += '#$element ';
      });
      return Scaffold(
        backgroundColor: Color(0xFF483D3F),
        appBar: HomeAppBar(
            pageContext: context,
            title: text.title,
            pagesLength: 1,
            currentPage: homeController.currentPage + 1),
        body: Stack(
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
                                    homeController.textController.text,
                                    style: TextStyle(fontFamily: 'EBGaramond'),
                                    textAlign: text.alignment == 'center'
                                        ? TextAlign.center
                                        : text.alignment == 'left'
                                            ? TextAlign.start
                                            : TextAlign.end,
                                  ),
                                ));
                          },
                          itemCount: 1,
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
                      icon:
                          Icon(Icons.person_add, size: 32, color: Colors.white),
                      onPressed: () {},
                    ),
                    Column(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            homeController.liked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 32,
                            color: homeController.liked
                                ? Colors.red
                                : Colors.white,
                          ),
                          onPressed: likedText,
                        ),
                        Text(text.likes.length.toString(),
                            style: smallStyleLight)
                      ],
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.comment, size: 32, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, '/comments', arguments: {
                          "currentText": homeController.currentText
                        });
                      },
                    ),
                    Text(text.comments.length.toString(),
                        style: smallStyleLight),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.share, size: 32, color: Colors.white),
                      onPressed: () {
                        sharedText(text);
                      },
                    ),
                  ],
                )),
          ],
        ),
      );
    });
  }
}
