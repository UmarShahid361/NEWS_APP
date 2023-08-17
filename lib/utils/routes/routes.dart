import 'package:NEWS/res/components/customDisplay.dart';
import 'package:NEWS/utils/routes/routes_name.dart';
import 'package:NEWS/view/categories_view.dart';
import 'package:NEWS/view/home_view.dart';
import 'package:NEWS/view/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeView());
      case RoutesName.categories:
        return MaterialPageRoute(builder: (context) => const CategoriesView());
      case RoutesName.detail:
        var arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => CustomDisplay(parameters: arguments));
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('No Route defined'),
            ),
          );
        });
    }
  }
}
