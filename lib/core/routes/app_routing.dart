
import 'package:cloudquizzer/core/routes/routes.dart';
import 'package:flutter/material.dart';
import '../../features/home/screen/ui/home_screen.dart';



class AppRouting {
  Route? generateRoutes(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());



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
