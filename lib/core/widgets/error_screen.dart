import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Lottie.asset('assets/lottie/error.json', width: 200.w, height: 200.h),
        SizedBox(height: 20.h),
        Text(
          'Something went wrong',
          style: GoogleFonts.roboto(
            fontSize: 20.sp,
          ),
        ),
      ])),
    );
  }
}
