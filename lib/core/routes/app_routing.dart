import 'package:cloudquizzer/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/exam/manager/exam_cubit.dart';
import '../../features/exam/screen/ui/exam_screen.dart';
import '../../features/home/screen/ui/home_screen.dart';
import '../../features/result/screen/ui/result_screen.dart';
import '../../features/review/screen/ui/review_question_screen.dart';

class AppRouting {
  Route? generateRoutes(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.examScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ExamCubit()..getQuestions(),
                  child: const ExamScreen(),
                ));

      case Routes.resultScreen:
        return MaterialPageRoute(
          builder: (_) => const ResultScreen(),
          settings: RouteSettings(arguments: arguments),
        );

      case Routes.reviewQuestionScreen:
        return MaterialPageRoute(
          builder: (_) => const ReviewQuestionScreen(),
          settings: RouteSettings(arguments: arguments),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
