
import 'package:flutter/material.dart';

import '../widget/home_screen_body.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: HomeScreenBody(),
    );
  }
}
