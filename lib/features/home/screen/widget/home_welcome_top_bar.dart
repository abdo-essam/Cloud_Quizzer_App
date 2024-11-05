import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWelcomeTopBar extends StatelessWidget {
  const HomeWelcomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(
            Icons.waving_hand_outlined,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(
            width: 10.w,
          ),
          Row(
            children: [
              Text(
                'Hello,',
                style: GoogleFonts.quicksand(
                  fontSize: 20.0.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' Welcome to ',
                style: GoogleFonts.quicksand(
                  fontSize: 20.0.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                'Cloud',
                style: GoogleFonts.quicksand(
                  fontSize: 20.0.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Quizzer',
                style: GoogleFonts.quicksand(
                  fontSize: 20.0.sp,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
