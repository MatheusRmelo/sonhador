import 'package:flutter/material.dart';

import 'placeholder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.deepOrange),
  ];

  void onTabTapped(int index) {
    if (index == 2) {
      Navigator.pushNamed(context, '/writer');
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
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
        backgroundColor: Color(0xFFc4c4c4),
        selectedItemColor: Colors.grey.withOpacity(.60),
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
                color: Colors.grey.withOpacity(.60),
              ),
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: 'Inicio'),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.search,
                color: Colors.grey.withOpacity(.60),
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
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFFe4e4e4)),
                width: 48,
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
                color: Colors.grey.withOpacity(.60),
              ),
              icon: Icon(Icons.library_books, color: Colors.black),
              label: 'Biblioteca'),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              color: Colors.grey.withOpacity(.60),
            ),
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
