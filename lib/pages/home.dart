import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/writerdata.dart';
import 'placeholder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _currentIndex = 0;
  TextStyle smallStyleLight =
      TextStyle(fontFamily: 'Fredoka One', fontSize: 12, color: Colors.white);

  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.deepOrange),
  ];

  void onTabTapped(int index) {
    if (index == 2) {
      //Navigator.pushNamed(context, '/writer');
      createNewText(context);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void createNewText(BuildContext pageContext) {
    showDialog(
        context: pageContext,
        builder: (BuildContext context) {
          return AlertDialog(
              scrollable: true,
              content: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(children: [
                    Container(
                        width: 200,
                        child: RaisedButton(
                            color: Color(0xFF9B9987),
                            onPressed: () async {
                              Map result =
                                  await Provider.of<WriterData>(context)
                                      .saveText('Sem título', ['']);
                              if (result['error'] != '') {
                                print(result['error']);
                              } else {
                                Navigator.pushNamed(context, '/writer',
                                    arguments: {"textId": result['data']});
                              }
                            },
                            child: Text(
                              'Nova história',
                              style: smallStyleLight,
                            ))),
                    Container(
                        width: 200,
                        child: RaisedButton(
                            color: Color(0xFF483D3F),
                            onPressed: () {
                              Navigator.pushNamed(context, '/search');
                            },
                            child: Text('Continuar história',
                                style: smallStyleLight))),
                  ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF9B9987),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: TextStyle(fontFamily: 'Fredoka One'),
        unselectedLabelStyle: TextStyle(fontFamily: 'Fredoka One'),
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: 'Inicio'),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              label: 'Descobrir'),
          BottomNavigationBarItem(
              activeIcon: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFFe4e4e4)),
                width: 32,
                height: 32,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              icon: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFe4e4e4)),
                width: 32,
                height: 32,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.library_books,
                color: Colors.white,
              ),
              icon: Icon(Icons.library_books, color: Colors.black),
              label: 'Biblioteca'),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
