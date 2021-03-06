import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';

class Input extends StatelessWidget {
  Input({@required this.title, this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primary_color,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF9B9987),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: smallTextLight,
            ),
            Container(
              margin: EdgeInsets.only(top: 16, bottom: 16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                //controller: editController.userDisplayController,
                initialValue: value,
                decoration: InputDecoration(
                  hintText: 'Digite aqui',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Container(
              width: widthDevice * 0.6,
              height: 40,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                color: Color(0xFF483D3F),
                onPressed: () {},
                child: Text(
                  'SALVAR',
                  style: smallStyleLight,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              width: widthDevice * 0.6,
              child: Text(
                'Escolha um nome que ajude as pessoas a te encontrar no mundo dos sonhos.',
                style: smallTextLight,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
