import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'certification_item/certification_item_list_view.dart';
import 'home_welcome_top_bar.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    // container is outside the safe area to show the status bar
    return Container(
      color: Colors.black,
      child: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: EdgeInsets.all(16.0.h),
              child: HomeWelcomeTopBar(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w , vertical: 8.0.h),
              child: Row(
                children: [
                  Text(
                    "Take Exam to Test Your Knowledge",
                    style: GoogleFonts.quicksand(
                        fontSize: 16.0.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                   Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                    size: 22.sp,
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: CertificationItemListView(),
            ),
          ],
        ),
      )),
    );
  }
}
