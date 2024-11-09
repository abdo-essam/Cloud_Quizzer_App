import 'package:cloudquizzer/features/history/screen/ui/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../bookmark/screen/ui/bookmark_screen.dart';
import '../../../result/screen/ui/result_screen.dart';
import '../widget/home_screen_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: GNav(
              curve: Curves.easeOutExpo,
              rippleColor: Colors.white.withOpacity(0.3),
              hoverColor: Colors.white.withOpacity(0.1),
              haptic: true,
              tabBorderRadius: 20,
              gap: 5,
              activeColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.deepOrange.withOpacity(0.7),
              textStyle: GoogleFonts.lato(
                color: Colors.white,
              ),
              tabs: [
                GButton(
                  iconSize: _selectedIndex != 0 ? 28 : 25,
                  icon: _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                  iconColor: _selectedIndex == 0 ? Colors.white : Colors.grey,
                  text: 'Home',
                ),
                GButton(
                  icon: _selectedIndex == 1
                      ? Icons.history
                      : Icons.history_outlined,
                  iconColor: _selectedIndex == 0 ? Colors.white : Colors.grey,
                  text: 'History Score',
                ),
                GButton(
                  iconSize: 28,
                  icon: _selectedIndex == 2
                      ? Icons.bookmark
                      : Icons.bookmark_outline,
                  iconColor: _selectedIndex == 0 ? Colors.white : Colors.grey,
                  text: 'Bookmark',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: updateCurrentIndex,
            ),
          ),
        ),
      ),
    );
  }

  final pages = [
    HomeScreenBody(),
    HistoryScreen(),
    BookmarkScreen(),
  ];
}
