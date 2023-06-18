import 'package:flutter/material.dart';
import 'package:rugby_mobile/homepage/MainScreen.dart';
import 'package:rugby_mobile/pages/scores/Scores.dart';
import 'package:rugby_mobile/pages/fixtures/fixtures.dart';
import 'package:rugby_mobile/video/videos.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    MainScreen(),
    const FixtureScreen(),
   // Videos(),
   SportsVideosPage(),
    Scores(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Color.fromARGB(255, 5, 38, 66)
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Fixtures',
                backgroundColor: Color.fromARGB(255, 5, 38, 66)
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_camera_back),
                label: 'Videos',
                backgroundColor: Color.fromARGB(255, 5, 38, 66)
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_rugby_outlined),
                label: 'Scores',
                
                backgroundColor: Color.fromARGB(255, 5, 38, 66)
                )
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber,
            onTap: _onItemTapped,
          ),
      );
}


