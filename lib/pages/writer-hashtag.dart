part of '../main.dart';

class HashTagPage extends StatefulWidget {
  @override
  _HashTagPage createState() => _HashTagPage();
}

class _HashTagPage extends State<HashTagPage> {
  bool loading = false;
  TextEditingController _controller = TextEditingController(text: '');

  void saveHashTags(String textId) async {
    setState(() {
      loading = true;
    });
    var result = await writer.saveHashTags(textId);
    if (result['data'] == 'success') {
      if (writer.text.getPublished()) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushNamed(context, '/publish', arguments: {"textId": textId});
      }
    } else {
      print(result['error']);
    }
    setState(() {
      loading = false;
    });
  }

  void initState() {
    super.initState();
    setState(() {
      _controller.text = writer.text.getHashtags();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> routeData = ModalRoute.of(context).settings.arguments;
    double heightDevice = MediaQuery.of(context).size.height;
    double widthDevice = MediaQuery.of(context).size.width;

    String textId = routeData['textId'];

    return Scaffold(
      backgroundColor: Color(0xFF9B9987),
      appBar: loading
          ? LoadingAppBar(pageContext: context, color: Color(0xFF9B9987))
          : CustomAppBar(
              pageContext: context, title: 'Escolha as # mais quentes!'),
      body: loading
          ? Loading(status: 'Carregando...')
          : Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    height: heightDevice * 0.25,
                    width: widthDevice * 0.8,
                    child: TextFormField(
                      controller: _controller,
                      style: TextStyle(fontFamily: 'EBGaramond'),
                      //controller: _controller,
                      textAlignVertical: TextAlignVertical.top,
                      textAlign: TextAlign.start,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (text) {
                        writer.text.setHashtags(text);
                      },
                      decoration: InputDecoration(
                        hintText: '#poema #amor #sonhador',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  Container(
                      width: 200,
                      height: 40,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            saveHashTags(textId);
                          },
                          child: Text('AVANÇAR',
                              style: TextStyle(
                                  fontFamily: 'Fredoka One',
                                  fontSize: 16,
                                  color: Color(0xFF483D3F))))),
                ],
              ),
            ),
    );
  }
}
