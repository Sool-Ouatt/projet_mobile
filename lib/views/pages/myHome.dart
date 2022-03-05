import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:samadeukuway/views/components/bodyHome1.dart';
import 'package:samadeukuway/views/components/navigation_drawer_widget.dart';
import 'package:samadeukuway/views/pages/ajoutNoticeSearch.dart';
import 'package:samadeukuway/views/pages/logementAjout.dart';
import '../components/bodyMessages.dart';
import '../components/bodySearchNotice.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    BodyHome1(),
    BodyNoticeSearch(),
    BodyMessages(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavigationDrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LogementAjout()),
            );
          },
        ),
      ),
      bottomNavigationBar: buildBonttomNavigationBar(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AjouterNoticeSearch()),
                );
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  BottomNavigationBar buildBonttomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Color(0xFF3C4046),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.my_library_add_outlined),
          label: 'Poster',
          backgroundColor: Color(0xFF3C4046),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
          label: 'Messages',
          backgroundColor: Color(0xFF3C4046),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
