import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoDataFoundedScreen extends StatelessWidget {
  const NoDataFoundedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/lottie/cloud_animation.json', width: 200.w, height: 200.h),
    );
  }
}
