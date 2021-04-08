import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share/share.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';
import 'package:sonhador/app/widgets/homecontentappbar.dart';
import 'package:sonhador/app/widgets/loading.dart';
import 'package:sonhador/app/widgets/homeappbar.dart';
import 'package:sonhador/app/widgets/loading_container.dart';
import 'package:sonhador/app/widgets/loginbottom.dart';
import 'package:sonhador/app/widgets/profilebox.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

import 'home_content_controller.dart';
import 'model/home_text_model.dart';

class HomeContentPage extends StatefulWidget {
  @override
  _HomeContentPage createState() => _HomeContentPage();
}

class _HomeContentPage extends State<HomeContentPage> {
  final homeController = Modular.get<HomeContentController>();
  final appController = Modular.get<AppController>();
  final InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: 'ca-app-pub-8444659371735623/5999438502',
    request: AdRequest(),
    listener: AdListener(),
  );
  final AdListener listener = AdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an ad is in the process of leaving the application.
    onApplicationExit: (Ad ad) => print('Left application.'),
  );
  String active = 'discovery';

  void prevPage() {
    appController.signOut();
    // if (homeController.currentPage != 0) {
    //   homeController.currentPage--;
    // }
    // homeController.textController.text = homeController.texts
    //     .value[homeController.currentText].pages[homeController.currentPage];
  }

  void nextPage(int index) {
    if ((homeController.currentPage + 1) !=
        homeController.texts.value[index].pages.length) {
      homeController.currentPage++;
      homeController.textController.text =
          homeController.texts.value[index].pages[homeController.currentPage];
    }
  }

  void nextText(int index) {
    int currentText = index;
    int qtdTexts = homeController.texts.value.length;
    if (index + 3 == homeController.texts.value.length) {
      homeController.fetchMoreTexts(
          homeController.texts.value[homeController.texts.value.length - 1].id);
    }
    if (currentText != qtdTexts || currentText <= qtdTexts) {
      //print(index);
      homeController.getMoreTexts();
      homeController.currentText = index;
      homeController.textController.text = homeController
          .texts.value[currentText].pages[homeController.currentPage];
    }
  }

  void likedText(int index) {
    if (appController.user.value.userId == '') {
      showbottomlogin(context);
    } else {
      homeController.currentText = index;

      homeController.likedText(appController.user.value.userId);
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
      homeController.sharedText(appController.user.value.userId);
    }
    Share.share(textShared);
  }

  void changeActive(String newActive) {
    setState(() {
      active = newActive;
    });
    if (active == 'following') {
      String lastId = homeController
          .texts.value[homeController.texts.value.length - 1].userId;
      homeController.fetchFollowTexts(lastId, appController.user.value.userId);
    } else {
      homeController.fetchTexts();
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    double widthDevice = MediaQuery.of(context).size.width;

    return Observer(builder: (_) {
      if (appController.user.value == null) {
        return Loading(
          status: 'Carregando...',
        );
      }
      if (homeController.texts.value == null) {
        return Loading(
          status: 'Carregando...',
        );
      }
      if (homeController.texts.value.length == 0) {
        //print(homeController.currentPage);
        return Loading(
          status: 'Carregando...',
        );
      }

      return Scaffold(
          backgroundColor: Colors.white,
          appBar: HomeContentAppBar(
              changeActive: changeActive,
              active: active,
              pageContext: context,
              showActive: appController.user.value.following.length <= 0),
          body: RefreshIndicator(
            onRefresh: () async {
              homeController.fetchMoreTexts(homeController
                  .texts.value[homeController.texts.value.length - 1].id);
              homeController.getMoreTexts();
            },
            child: TikTokStyleFullPageScroller(
              contentSize: homeController.texts.value.length,
              builder: (BuildContext context, int index) {
                return Observer(
                  builder: (_) {
                    var text = homeController.texts.value[index];
                    homeController.textController.text =
                        text.pages[homeController.currentPage];
                    String hashtags = '';
                    text.hashtags.forEach((element) {
                      if (element != '') {
                        hashtags += '#$element ';
                      }
                    });
                    var rng = new Random();
                    var randomNumber = rng.nextInt(100);
                    if (randomNumber >= 70) {
                      myInterstitial.load();
                      myInterstitial.show();
                    }
                    bool liked = homeController.texts.value[index].likes
                        .contains(appController.user.value.userId);

                    bool follow = appController.user.value.following
                        .contains(homeController.texts.value[index].userId);
                    if (homeController.texts.value[index].userId ==
                        appController.user.value.userId) {
                      follow = true;
                    }
                    return Stack(children: [
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
                                                offset:
                                                    Offset.fromDirection(1, 1),
                                                spreadRadius: 0),
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height: heightDevice * 0.65,
                                      child: Container(
                                        padding: EdgeInsets.all(16),
                                        width: widthDevice * 1,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 8),
                                              alignment: Alignment.center,
                                              child: Text(
                                                text.title,
                                                style: smallStyle,
                                              ),
                                            ),
                                            Container(
                                              alignment:
                                                  text.alignment == 'center'
                                                      ? Alignment.center
                                                      : text.alignment == 'left'
                                                          ? Alignment.topLeft
                                                          : Alignment.topRight,
                                              child: Text(
                                                homeController
                                                    .textController.text,
                                                style: TextStyle(
                                                    fontFamily: 'EBGaramond'),
                                                textAlign: text.alignment ==
                                                        'center'
                                                    ? TextAlign.center
                                                    : text.alignment == 'left'
                                                        ? TextAlign.start
                                                        : TextAlign.end,
                                              ),
                                            )
                                          ],
                                        ),
                                      ))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    hashtags,
                                    style: smallStyle,
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
                              Text(''),
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
                              Text(
                                '${homeController.currentPage + 1}/${text.pages.length}',
                                style: smallStyle,
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  nextPage(index);
                                },
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
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Icon(
                                                Icons.add,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {
                                              if (appController
                                                      .user.value.userId ==
                                                  '') {
                                                showbottomlogin(context);
                                              } else {
                                                appController
                                                    .newFollow(text.userId);
                                                homeController.currentPage =
                                                    homeController.currentPage;
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
                                      liked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 32,
                                      color: liked ? Colors.red : Colors.black,
                                    ),
                                    onPressed: () {
                                      likedText(index);
                                    },
                                  ),
                                  Text(text.likes.length.toString(),
                                      style: smallStyle)
                                ],
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.comment,
                                    size: 32, color: Colors.black),
                                onPressed: () {
                                  homeController.currentText = index;
                                  Modular.to
                                      .pushNamed('/home/comment', arguments: {
                                    "text": homeController.texts.value[index]
                                  });
                                },
                              ),
                              Text(text.comments.length.toString(),
                                  style: smallStyle),
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.share,
                                    size: 32, color: Colors.black),
                                onPressed: () {
                                  sharedText(text);
                                },
                              ),
                            ],
                          )),
                    ]);
                  },
                );
              },
            ),
          ));
    });
  }
}
