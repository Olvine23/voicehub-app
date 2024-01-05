// bottom_nav_bar.dart

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GNav(
        tabs: [
          GButton(
            text: 'Home',
            icon: Icons.home,
          ),
          GButton(
            text: 'Search',
            icon: Icons.search,
          ),
          GButton(
            text: 'Favorites',
            icon: Icons.favorite,
          ),
          GButton(
            text: 'Profile',
            icon: Icons.person,
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
