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

void main() async{
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
