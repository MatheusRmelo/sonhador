part of '../main.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  List<Map> texts = [];
  String error = '';
  bool loading = false;

  void doSearch(text) {
    List newTexts = writer.searchText(text);
    setState(() {
      texts = newTexts;
    });
  }

  void getTexts() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      loading = true;
    });
    await writer.getMyTexts('matheusRmelo');
    //await Provider.of<WriterData>(context).getMyTexts();
    setState(() {
      loading = false;
    });
  }

  void initState() {
    super.initState();

    getTexts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            pageContext: context, title: 'Jovem, pesquise seu texto abaixo'),
        backgroundColor: Color(0xFF9B9987),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
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
                  doSearch(text);
                },
              ),
            ),
            Expanded(
                child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(
                  texts.length,
                  (index) => TextBox(
                        textId: texts[index]['id'] != null
                            ? texts[index]['id']
                            : '',
                        title: texts[index]['text']['title'] != null
                            ? texts[index]['text']['title']
                            : '',
                        onTap: (textId) {
                          Navigator.pushNamed(context, '/writer',
                              arguments: {"textId": textId});
                        },
                      )),
            ))
          ],
        ));
  }
}
