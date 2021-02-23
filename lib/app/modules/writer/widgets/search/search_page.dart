import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/modules/writer/widgets/search/search_controller.dart';
import 'package:sonhador/app/utils/loading_container.dart';
import '../../../../utils/loading.dart';
import '../../../../utils/customappbar.dart';
import '../../../../utils/textbox.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final searchController = Modular.get<SearchController>();

  void getTexts() async {
    searchController.fetchTexts('matheusRmelo');
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
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
        return Scaffold(
            appBar: CustomAppBar(
                pageContext: context,
                title: 'Jovem, pesquise seu texto abaixo'),
            backgroundColor: Color(0xFF9B9987),
            body: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.all(16),
                  child: TextFormField(
                    style: TextStyle(fontFamily: 'Fredoka One', fontSize: 12),
                    decoration: InputDecoration(
                        hintText: 'Digite o nome do seu texto',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        suffixIcon: Icon(
                          Icons.search,
                          size: 32,
                        )),
                    onChanged: (text) {
                      searchController.searchText('matheusRmelo', text);
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
                                  textId: texts[index].id,
                                  title: texts[index].title,
                                  onTap: (textId) {
                                    Navigator.pushNamed(context, '/writer',
                                        arguments: {"textId": textId});
                                  },
                                )),
                      ))
              ],
            ));
      },
    );
  }
}
