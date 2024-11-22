import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/constants/constants.dart';
import '../../../../../core/models/certification.dart';
import 'certification_item.dart';

class CertificationItemListView extends StatelessWidget {
  CertificationItemListView({super.key});

  // get certification data from Constants
  final List<Certification> certificationsDataList =
      Constants.certificationsData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 540.h,
      width: double.infinity,
      child: ListView.builder(
          itemBuilder: (context, index) {
            return CertificationItem(certification: certificationsDataList[index]);
          },
          itemCount: certificationsDataList.length),
    );
  }
}
