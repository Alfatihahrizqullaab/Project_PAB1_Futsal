import 'package:app_lapangan_futsal/screen/favorite_screen.dart';
import 'package:app_lapangan_futsal/screen/home_screen.dart';
import 'package:app_lapangan_futsal/screen/profile_screen.dart';
import 'package:app_lapangan_futsal/screen/tournament_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_lapangan_futsal/data/lapangan_data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Deklarasi Variable
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    TournamentScreen(),
    FavoriteScreen(allFields: fields),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Event',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_outlined),
              label: 'favorite',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey[600],
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
