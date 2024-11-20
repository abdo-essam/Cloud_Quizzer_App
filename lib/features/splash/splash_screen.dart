import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/routes/routes.dart';
import '../../core/theme/color_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: _buildLogo(),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
          child: ImageIcon(
            const AssetImage('assets/images/cloud.png'),
            color: ColorManager.primaryColor,
            size: 70.r,
          ),
        ),
        Text(
          'Cloud',
          style: _buildTextStyle(
            fontSize: 32.sp,
            color: ColorManager.white,
          ),
        ),
        Text(
          'Quizzer',
          style: _buildTextStyle(
            fontSize: 32.sp,
            color: ColorManager.primaryColor,
          ),
        ),
      ],
    );
  }

  TextStyle _buildTextStyle({
    required double fontSize,
    required Color color,
  }) {
    return GoogleFonts.quicksand(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
    );
  }
}
