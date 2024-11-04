import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'certification_item.dart';

class CertificationItemListView extends StatelessWidget {
  const CertificationItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 530.h,
      child: ListView.builder(
          itemBuilder: (context, index) {
            return const CertificationItem();
          },
          itemCount: 10),
    );
  }
}
