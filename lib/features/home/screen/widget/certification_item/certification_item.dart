import 'package:cloudquizzer/core/models/certification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/routes/routes.dart';

class CertificationItem extends StatefulWidget {
  const CertificationItem({super.key, required this.certification});

  final Certification certification;

  @override
  State<CertificationItem> createState() => _CertificationItemState();
}

class _CertificationItemState extends State<CertificationItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).popAndPushNamed(
          Routes.examScreen,
          arguments: {
            'certification': widget.certification,
          },
        );
      },
      child: Container(
        height: 150.h,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Image(
                    width: 100.w,
                    height: 85.w,
                    fit: BoxFit.values[1],
                    image: AssetImage(widget.certification.imagePath)),
                SizedBox(width: 20.w),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.certification.certificationName,
                      style: GoogleFonts.quicksand(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      widget.certification.certificationCode,
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
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline,
                          color: Colors.deepOrange, size: 20.0),
                      SizedBox(width: 10.w),
                      Text(
                        "${widget.certification.numOfQuestions} Questions",
                        style: GoogleFonts.quicksand(
                            fontSize: 13.sp, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined,
                          color: Colors.deepOrange, size: 20.0),
                      SizedBox(width: 10.w),
                      Text(
                        "${widget.certification.examTime} Mins",
                        style: GoogleFonts.quicksand(
                            fontSize: 13, color: Colors.black),
                      ),
                    ],
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
