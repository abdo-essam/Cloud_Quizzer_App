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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: HomeWelcomeTopBar(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                  const Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                    size: 22,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
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
