import 'package:flutter/material.dart';
import 'package:hackl_app/components.dart';
import 'package:hackl_app/filterPage.dart';
import 'package:hackl_app/searchPage.dart';
import 'eventOverviewPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bottom Navigation Bar',
      theme: ThemeData(
        primaryColor: Color(0xFF3B1FA3), // Hexadecimal color for #3B1FA3
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF3B1FA3),
          secondary: Colors.white, // Optional secondary color
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    EventOverviewPage(), // Your new home page
    SearchEventsPage(), // Your new home page
    FilterPage(), // Your new home page
    EventOverviewPage(), // Your new home page
    EventOverviewPage(), // Your new home page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        showSelectedLabels: false, // Hides selected item labels
        showUnselectedLabels: false, // Hides unselected item labels
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
