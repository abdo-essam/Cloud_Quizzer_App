import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/routes/routes.dart';

class CertificationItem extends StatelessWidget {
  const CertificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.examScreen);
      },
      child: Container(
        height: 140.h,
        width: 170.w,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                 Image(
                  width: 100.w,
                  height: 85.w,
                    fit: BoxFit.cover ,
                    image: const AssetImage(
                        'assets/images/aws_cloud_practitioner_badge.png')),
                SizedBox(width: 20.w),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AWS Cloud Practitioner',
                      style: GoogleFonts.quicksand(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'CLF-C02',
                      style: GoogleFonts.quicksand(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ))
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline,
                      color: Colors.deepOrange, size: 20.0),
                  SizedBox(width: 10.w),
                  Text(
                    "60 questions",
                    style: GoogleFonts.quicksand(fontSize: 13.sp , color: Colors.black),
                  ),
                  SizedBox(width: 10.w),
                  const Icon(Icons.timer_outlined,
                      color: Colors.deepOrange, size: 20.0),
                  SizedBox(width: 10.w),
                  Text(
                    "120 mins",
                    style: GoogleFonts.quicksand(fontSize: 13 , color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
