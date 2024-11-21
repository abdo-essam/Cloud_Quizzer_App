import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/color_manager.dart';
import 'certification_item/certification_item_list_view.dart';
import 'home_welcome_top_bar.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.black,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: HomeWelcomeTopBar(),
              ),
              const _ExamHeader(),
              // Using Expanded to ensure proper scrolling
              Expanded(
                child: SingleChildScrollView(
                  child: CertificationItemListView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExamHeader extends StatelessWidget {
  const _ExamHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Take Exam to Test Your Knowledge",
              style: _examTextStyle(),
            ),
          ),
          SizedBox(width: 15.w),
          Icon(
            Icons.arrow_circle_right_outlined,
            color: ColorManager.white,
            size: 22.sp,
          ),
        ],
      ),
    );
  }

  TextStyle _examTextStyle() {
    return GoogleFonts.quicksand(
      fontSize: 16.0.sp,
      color: ColorManager.white,
      fontWeight: FontWeight.w600,
    );
  }
}
