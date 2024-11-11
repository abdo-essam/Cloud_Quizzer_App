import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/routes/routes.dart';
import '../../core/theme/color_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
    });

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: const ImageIcon(
                  AssetImage('assets/images/cloud.png'),
                  color: ColorManager.primaryColor,
                  size: 70,
                ),
              ),
              Text(
                'Cloud',
                style: GoogleFonts.quicksand(
                    fontSize: 32.0.sp,
                    color: ColorManager.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              Text(
                'Quizzer',
                style: GoogleFonts.quicksand(
                  fontSize: 32.0.sp,
                  color: ColorManager.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
