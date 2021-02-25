import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:share/share.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/utils/fonts.dart';
import 'package:sonhador/app/utils/loading.dart';
import 'package:sonhador/partials/homeappbar.dart';

import 'home_content_controller.dart';
import 'model/home_text_model.dart';

class HomeContentPage extends StatefulWidget {
  @override
  _HomeContentPage createState() => _HomeContentPage();
}

class _HomeContentPage extends State<HomeContentPage> {
  final homeController = Modular.get<HomeContentController>();
  final appController = Modular.get<AppController>();

  void prevPage() {
    if (homeController.currentPage != 0) {
      homeController.currentPage--;
    }
    homeController.textController.text = homeController.texts
        .value[homeController.currentText].pages[homeController.currentPage];
  }

  void nextPage() {
    if ((homeController.currentPage + 1) !=
        homeController.texts.value[homeController.currentText].pages.length) {
      homeController.currentPage++;
      homeController.textController.text = homeController.texts
          .value[homeController.currentText].pages[homeController.currentPage];
    }
  }

  void nextText(int index) {
    int currentText = index + 1;
    int qtdTexts = homeController.texts.value.length;

    if (currentText != qtdTexts || currentText <= qtdTexts) {
      homeController.currentText = index;
      homeController.textController.text = homeController.texts
          .value[homeController.currentText].pages[homeController.currentPage];
    }
  }

  void likedText() {
    homeController.likedText(appController.user.value.userName);
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
      bool liked = homeController.texts.value[homeController.currentText].likes
          .contains(appController.user.value.userName);

      return Scaffold(
        backgroundColor: Color(0xFF483D3F),
        appBar: HomeAppBar(
            pageContext: context,
            title: text.title,
            pagesLength: text.pages.length,
            currentPage: homeController.currentPage + 1),
        body: Stack(
          children: [
            Positioned(
                left: 56,
                right: 56,
                child: Column(
                  children: [
                    Container(
                        height: heightDevice * 0.70,
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
                          itemCount: homeController.texts.value.length,
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
                            liked ? Icons.favorite : Icons.favorite_border,
                            size: 32,
                            color: liked ? Colors.red : Colors.white,
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
                        Modular.to.pushNamed('/home/comment');
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
