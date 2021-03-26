import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share/share.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/home/home_content/model/home_text_model.dart';
import 'package:sonhador/app/modules/home/home_content/widgets/text/discovery_text_controller.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';
import 'package:sonhador/app/widgets/loading.dart';
import 'package:sonhador/app/widgets/homeappbar.dart';
import 'package:sonhador/app/widgets/loginbottom.dart';
import 'package:sonhador/app/widgets/profilebox.dart';

class DiscoveryTextPage extends StatefulWidget {
  @override
  _DiscoveryTextPage createState() => _DiscoveryTextPage();
}

class _DiscoveryTextPage extends State<DiscoveryTextPage> {
  final appController = Modular.get<AppController>();
  final discoveryController = Modular.get<DiscoveryTextController>();

  void prevPage() {
    if (discoveryController.currentPage != 0) {
      print(discoveryController.currentPage);
      discoveryController.currentPage--;
    }
    discoveryController.textController.text =
        discoveryController.text.value.pages[discoveryController.currentPage];
  }

  void nextPage() {
    if ((discoveryController.currentPage + 1) !=
        discoveryController.text.value.pages.length) {
      discoveryController.currentPage++;
      discoveryController.textController.text =
          discoveryController.text.value.pages[discoveryController.currentPage];
    }
  }

  void likedText() {
    if (appController.user.value.userId == '') {
      showbottomlogin(context);
    } else {
      discoveryController.likedText(appController.user.value.userId);
    }
  }

  void sharedText(HomeTextModel text) async {
    String author = await appController.getUserName(text.userId);
    String textShared = '';
    textShared += text.title + '\n\n';
    int page = 0;
    text.pages.forEach((element) {
      textShared +=
          (page + 1).toString() + '/' + text.pages.length.toString() + '\n\n';
      textShared += element + '\n\n\n';
      page++;
    });
    textShared += 'Autor: ' + author;
    if (appController.user.value.userId != '') {
      discoveryController.sharedText(appController.user.value.userId);
    }
    Share.share(textShared);
  }

  void getText() async {
    await Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> routeData = ModalRoute.of(context).settings.arguments;
    String textId = routeData['textId'];
    discoveryController.fetchText(textId);
    discoveryController.loading = false;
  }

  void initState() {
    super.initState();
    discoveryController.loading = true;
    getText();
  }

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    double widthDevice = MediaQuery.of(context).size.width;

    return Observer(builder: (_) {
      if (discoveryController.text == null ||
          discoveryController.text.value == null) {
        return Loading(
          status: 'Carregando...',
          color: Color(0xFF483D3F),
        );
      }
      if (appController.user.value == null) {
        return Loading(
          status: 'Carregando...',
          color: Color(0xFF483D3F),
        );
      }
      if (discoveryController.loading) {
        return Loading(
          status: 'Carregando...',
          color: Color(0xFF483D3F),
        );
      }

      var text = discoveryController.text.value;
      discoveryController.textController.text =
          discoveryController.text.value.pages[discoveryController.currentPage];
      String hashtags = '';
      text.hashtags.forEach((element) {
        if (element != '') {
          hashtags += '#$element ';
        }
      });
      bool liked = text.likes.contains(appController.user.value.userId);

      bool follow = appController.user.value.following.contains(text.userId);
      if (text.userId == appController.user.value.userId) {
        follow = true;
      }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: HomeAppBar(
            showBack: true,
            pageContext: context,
            title: text.title,
            pagesLength: text.pages.length,
            currentPage: discoveryController.currentPage + 1),
        body: Stack(
          children: [
            Positioned(
                left: 56,
                right: 56,
                child: Column(
                  children: [
                    Container(
                        height: heightDevice * 0.70,
                        child: Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset.fromDirection(1, 1),
                                      spreadRadius: 0),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            height: heightDevice * 0.65,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              width: widthDevice * 1,
                              child: Text(
                                discoveryController.textController.text,
                                style: TextStyle(fontFamily: 'EBGaramond'),
                                textAlign: text.alignment == 'center'
                                    ? TextAlign.center
                                    : text.alignment == 'left'
                                        ? TextAlign.start
                                        : TextAlign.end,
                              ),
                            ))),
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
                        color: Colors.black,
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
                        color: Colors.black,
                      ),
                      onPressed: nextPage,
                    ),
                    Stack(
                      children: [
                        Positioned(
                          child: GestureDetector(
                            child: ProfileBox(
                              size: 40,
                              photoURL: text.photoUrl,
                              color: primary_color,
                            ),
                            onTap: () {
                              Modular.to.pushNamed('/home/profile',
                                  arguments: {"userId": text.userId});
                            },
                          ),
                        ),
                        follow
                            ? Container()
                            : Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: primary_color,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    if (appController.user.value.userId == '') {
                                      showbottomlogin(context);
                                    } else {
                                      appController.newFollow(text.userId);
                                      discoveryController.currentPage =
                                          discoveryController.currentPage;
                                    }
                                  },
                                ))
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            liked ? Icons.favorite : Icons.favorite_border,
                            size: 32,
                            color: liked ? Colors.red : Colors.black,
                          ),
                          onPressed: likedText,
                        ),
                        Text(text.likes.length.toString(), style: smallStyle)
                      ],
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.comment, size: 32, color: Colors.black),
                      onPressed: () {
                        Modular.to.pushNamed('/home/comment', arguments: {
                          "text": discoveryController.text.value
                        });
                      },
                    ),
                    Text(text.comments.length.toString(), style: smallStyle),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.share, size: 32, color: Colors.black),
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
