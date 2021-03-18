import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/discovery/widgets/search/discovery_search_controller.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/widgets/loading_container.dart';
import 'package:sonhador/app/widgets/tabsbar.dart';
import 'package:sonhador/app/widgets/textbox.dart';
import 'package:sonhador/app/widgets/userbox.dart';

class DiscoverySearchPage extends StatefulWidget {
  @override
  _DiscoverySearchPage createState() => _DiscoverySearchPage();
}

class _DiscoverySearchPage extends State<DiscoverySearchPage> {
  final searchController = Modular.get<DiscoverySearchController>();
  final appController = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Observer(
            builder: (_) {
              if (searchController.texts.error != null) {
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

              var texts = searchController.texts.value;
              var users = searchController.users.value;
              return Scaffold(
                  appBar: TabsAppBar(
                      pageContext: context,
                      title: 'Jovem, pesquise tudo aqui em baixo',
                      color: secondary_color,
                      itemsColor: Colors.white,
                      tabs: [
                        Tab(icon: Icon(Icons.menu_book)),
                        Tab(icon: Icon(Icons.person)),
                      ]),
                  backgroundColor: Color(0xFF9B9987),
                  body: TabBarView(
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16)),
                            margin: EdgeInsets.all(16),
                            child: TextFormField(
                              style: TextStyle(
                                  fontFamily: 'Fredoka One', fontSize: 12),
                              decoration: InputDecoration(
                                  hintText: 'Pesquise aqui um texto...',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  suffixIcon: Icon(
                                    Icons.search,
                                    size: 32,
                                  )),
                              onChanged: (text) {
                                searchController.searchText(text);
                              },
                            ),
                          ),
                          searchController.texts.value == null
                              ? LoadingContainer(
                                  status: 'Carregando...',
                                  expanded: true,
                                )
                              : Expanded(
                                  child: GridView.count(
                                  crossAxisCount: 3,
                                  children: List.generate(
                                      texts.length,
                                      (index) => TextBox(
                                            imgUrl: texts[index].photoURL,
                                            textId: texts[index].id,
                                            title: texts[index].title,
                                            onTap: (textId) {
                                              Modular.to.pushNamed('/home/text',
                                                  arguments: {
                                                    "textId": textId
                                                  });
                                            },
                                          )),
                                ))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16)),
                            margin: EdgeInsets.all(16),
                            child: TextFormField(
                              style: TextStyle(
                                  fontFamily: 'Fredoka One', fontSize: 12),
                              decoration: InputDecoration(
                                  hintText: 'Pesquise aqui um usuário...',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  suffixIcon: Icon(
                                    Icons.search,
                                    size: 32,
                                  )),
                              onChanged: (text) {
                                searchController.searchUser(text);
                              },
                            ),
                          ),
                          searchController.users.value == null
                              ? LoadingContainer(
                                  status: 'Carregando...',
                                  expanded: true,
                                )
                              : Expanded(
                                  child: GridView.count(
                                  crossAxisCount: 3,
                                  children: List.generate(
                                      users.length,
                                      (index) => UserBox(
                                            showName: true,
                                            userId: users[index].userId,
                                            userName: users[index].userName,
                                            onTap: (userId) {
                                              if (appController
                                                      .user.value.userId !=
                                                  userId) {
                                                Modular.to.pushNamed(
                                                    '/home/profile',
                                                    arguments: {
                                                      "userId": userId
                                                    });
                                              }
                                            },
                                          )),
                                ))
                        ],
                      )
                    ],
                  ));
            },
          ),
        ));
  }
}
