import 'package:flutter/material.dart';

import '../widget/result_screen_body.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: ResultScreenBody(),
    );
  }
}
