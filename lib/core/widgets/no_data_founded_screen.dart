import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataFoundedScreen extends StatelessWidget {
  const NoDataFoundedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          "No Data Founded",
          style: GoogleFonts.roboto(fontSize: 20.sp, color: Colors.red),
        ),
      ),
    );
  }
}
