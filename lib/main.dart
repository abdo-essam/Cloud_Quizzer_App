import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudquizzer/core/theme/color_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/bloc_observer.dart';
import 'core/models/bookmark.dart';
import 'core/models/score.dart';
import 'core/routes/app_routing.dart';
import 'core/routes/routes.dart';
import 'core/utils/question_uploader.dart';

void main() async{
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Enable offline persistence (optional)
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  // Upload questions
 // await QuestionUploader.uploadMultiChoiceQuestions();
  Hive.registerAdapter(ScoreAdapter());
  Hive.registerAdapter(BookmarkAdapter());
  await Hive.initFlutter();
  await Hive.openBox('scoresBox');
  await Hive.openBox('bookmarks');

  runApp(MyApp(
    appRouting: AppRouting(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouting});

  final AppRouting appRouting;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true, primaryColor: ColorManager.primaryColor),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouting.generateRoutes,
        initialRoute: Routes.splashScreen,
      ),
    );
  }
}
