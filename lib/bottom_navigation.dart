import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'View/Beranda/nav_beranda.dart';
import 'View/Profile/nav_profile.dart';
import 'View/Tagihan/nav_tagihan.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  // ignore: prefer_final_fields
  List _pages = [
    NavBeranda(),
    NavTagihan(),
    NavProfile(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const RgbColor(63, 13, 18),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          backgroundColor: const RgbColor(63, 13, 18),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          padding:  const EdgeInsets.all(16),
          gap: 8,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
             GButton(
              icon: Icons.home,
              text: 'Beranda',
            ),
            GButton(
              icon: Icons.receipt_long,
              text: 'Tagihan',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          
          ],
        ),
        
      ),
      body: _pages.elementAt(_selectedIndex),
    );
  }
}
