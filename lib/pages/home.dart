part of '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

String userId = '';

class _HomePage extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green),
    userId != '' ? PlaceholderWidget(Colors.deepOrange) : NoUserWidget(),
    userId != '' ? PlaceholderWidget(Colors.deepOrange) : NoUserWidget(),
  ];

  void onTabTapped(int index) {
    if (index == 2) {
      //Navigator.pushNamed(context, '/writer');
      createNewText(context);
    } else {
      if (index == 4) {
        Navigator.pushNamed(context, '/swiper');
      } else {
        setState(() {
          _currentIndex = index;
        });
      }
    }
  }

  void newText() async {
    Map result = await writer.createText(
        userId: 'matheusRmelo', newTitle: 'Novo título');
    if (result['error'] != '') {
      print(result['error']);
    } else {
      Navigator.pushNamed(context, '/writer',
          arguments: {"textId": result['data']});
    }
  }

  void createNewText(BuildContext pageContext) {
    showDialog(
        context: pageContext,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              scrollable: true,
              content: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(children: [
                    Container(
                        width: 200,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Color(0xFF9B9987),
                            onPressed: newText,
                            child: Text(
                              'Nova história',
                              style: smallStyleLight,
                            ))),
                    Container(
                        width: 200,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
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
