import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/color_manager.dart';

class HomeWelcomeTopBar extends StatelessWidget {
  const HomeWelcomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Define reusable text style
    final baseTextStyle = GoogleFonts.quicksand(
      fontSize: 18.sp,
      color: ColorManager.white,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.waving_hand_outlined,
          color: ColorManager.white,
          size: 20,
        ),
        SizedBox(width: 10.w),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Hello, ',
                style: baseTextStyle,
              ),
              TextSpan(
                text: 'Welcome to ',
                style: baseTextStyle,
              ),
              TextSpan(
                text: 'Cloud',
                style: baseTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Quizzer',
                style: baseTextStyle.copyWith(color: ColorManager.primaryColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
