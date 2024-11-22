  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:google_fonts/google_fonts.dart';

  import '../../../../../core/routes/routes.dart';
  import '../../../../../core/theme/color_manager.dart';
  import '../../../../../core/models/certification.dart';

  class CertificationItem extends StatefulWidget {
    const CertificationItem({super.key, required this.certification});

    final Certification certification;

    @override
    State<CertificationItem> createState() => _CertificationItemState();
  }

  class _CertificationItemState extends State<CertificationItem> {
    @override
    Widget build(BuildContext context) {
      final titleStyle = GoogleFonts.quicksand(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: ColorManager.black,
      );

      final subTitleStyle = GoogleFonts.quicksand(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: ColorManager.black,
      );

      final infoTextStyle = GoogleFonts.quicksand(
        fontSize: 13.sp,
        color: ColorManager.black,
      );

      return GestureDetector(
        onTap: () {
          Navigator.of(context).popAndPushNamed(
            Routes.examScreen,
            arguments: {'certification': widget.certification},
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: ColorManager.cultured,
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Dynamic height
            children: [
              Row(
                children: [
                  Image.asset(
                    widget.certification.imagePath,
                    width: 100.w,
                    height: 85.w,
                    fit: BoxFit.values[1],
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.certification.certificationName,
                          style: titleStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          widget.certification.certificationCode,
                          style: subTitleStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: ColorManager.primaryColor,
                        size: 20.0,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "${widget.certification.numOfQuestions} Questions",
                        style: infoTextStyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        color: ColorManager.primaryColor,
                        size: 20.0,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "${widget.certification.examTime} Mins",
                        style: infoTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
