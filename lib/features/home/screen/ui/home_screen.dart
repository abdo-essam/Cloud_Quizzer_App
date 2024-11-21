import 'package:cloudquizzer/features/history/screen/ui/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../core/theme/color_manager.dart';
import '../../../bookmark/screen/ui/bookmark_screen.dart';
import '../widget/home_screen_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens for navigation
  final List<Widget> pages = [
    const HomeScreenBody(),
    const HistoryScreen(),
    const BookmarkScreen(),
  ];

  void _updateCurrentIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    // Common padding and styles
    const double iconSize = 28.0;
    final TextStyle textStyle = GoogleFonts.lato(color: ColorManager.white);
    final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12);

    return Container(
      color: ColorManager.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: GNav(
            curve: Curves.easeOutExpo,
            rippleColor: ColorManager.white.withOpacity(0.3),
            hoverColor: ColorManager.white.withOpacity(0.1),
            haptic: true,
            tabBorderRadius: 20,
            gap: 5,
            activeColor: Colors.white,
            padding: padding,
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: ColorManager.primaryColor.withOpacity(0.7),
            textStyle: textStyle,
            tabs: [
              GButton(
                iconSize: iconSize,
                icon: _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                iconColor: _selectedIndex == 0 ? ColorManager.white : ColorManager.grayX,
                text: 'Home',
              ),
              GButton(
                iconSize: iconSize,
                icon: _selectedIndex == 1 ? Icons.history : Icons.history_outlined,
                iconColor: _selectedIndex == 1 ? ColorManager.white : ColorManager.grayX,
                text: 'History Score',
              ),
              GButton(
                iconSize: iconSize,
                icon: _selectedIndex == 2 ? Icons.bookmark : Icons.bookmark_outline,
                iconColor: _selectedIndex == 2 ? ColorManager.white : ColorManager.grayX,
                text: 'Bookmark',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: _updateCurrentIndex,
          ),
        ),
      ),
    );
  }
}
