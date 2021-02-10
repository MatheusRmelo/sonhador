part of '../main.dart';

class PublishPage extends StatefulWidget {
  @override
  _PublishPage createState() => _PublishPage();
}

class _PublishPage extends State<PublishPage> {
  bool loading = false;
  bool _ads = true;

  void publishText(String textId) async {
    setState(() {
      loading = true;
    });
    var result = await writer.publishText(textId);
    if (result['data'] == 'success') {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      print(result['error']);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> routeData = ModalRoute.of(context).settings.arguments;
    double heightDevice = MediaQuery.of(context).size.height;

    String textId = routeData['textId'];
    String userId = 'matheusRmelo';
    String title = writer.text.getTitle();

    return Scaffold(
      backgroundColor: Color(0xFF9B9987),
      appBar: loading
          ? LoadingAppBar(pageContext: context, color: Color(0xFF9B9987))
          : CustomAppBar(pageContext: context, title: 'Jovem, publique agora!'),
      body: loading
          ? Loading(status: 'Carregando...')
          : Center(
              child: Column(
                children: [
                  TextBox(
                    textId: textId,
                    title: title,
                    height: 135,
                    width: 120,
                    credit: true,
                    social: userId,
                  ),
                  Container(
                    height: heightDevice * 0.3,
                    child: Column(children: [
                      // CheckboxListTile(
                      // checkColor: Colors.white,
                      // activeColor: Colors.black,
                      //   title: Text('O texto contém contéudo adulto',
                      //       style: smallText),
                      //   value: writer.adult,
                      //   onChanged: (val) {
                      //     writer.adult = val;
                      //   },
                      // ),
                      CheckboxListTile(
                        checkColor: Colors.white,
                        activeColor: Colors.black,
                        title: Text(
                          'Monetizar esse texto',
                          style: smallText,
                        ),
                        value: _ads,
                        onChanged: (val) {
                          setState(() {
                            _ads = val;
                          });
                          writer.text.setAds(_ads);
                        },
                      ),
                    ]),
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
                            publishText(textId);
                          },
                          child: Text('PUBLICAR',
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
