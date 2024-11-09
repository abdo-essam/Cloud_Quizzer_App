import 'package:cloudquizzer/core/routes/routes.dart';
import 'package:cloudquizzer/features/history/manager/history_cubit.dart';
import 'package:cloudquizzer/features/history/screen/ui/history_screen.dart';
import 'package:cloudquizzer/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/exam/manager/exam_cubit.dart';
import '../../features/exam/screen/ui/exam_screen.dart';
import '../../features/home/screen/ui/home_screen.dart';
import '../../features/result/manager/result_cubit.dart';
import '../../features/result/screen/ui/result_screen.dart';
import '../../features/review/screen/ui/review_question_screen.dart';
import '../models/certification.dart';

class AppRouting {
  Route? generateRoutes(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.examScreen:
        final args = arguments as Map<String, dynamic>;
        final Certification certification = args['certification'];
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ExamCubit()..getQuestions(certification),
            child: const ExamScreen(),
          ),
          settings: RouteSettings(arguments: arguments),
        );

      case Routes.resultScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => ResultCubit(),
              child: const ResultScreen()),
          settings: RouteSettings(arguments: arguments),
        );

      case Routes.reviewQuestionScreen:
        return MaterialPageRoute(
          builder: (_) => const ReviewQuestionScreen(),
          settings: RouteSettings(arguments: arguments),
        );

      case Routes.historyScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => HistoryCubit(),
                child: const HistoryScreen()));

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
