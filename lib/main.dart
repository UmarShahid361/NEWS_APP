import 'package:NEWS/res/colors.dart';
import 'package:NEWS/utils/routes/routes.dart';
import 'package:NEWS/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        secondaryHeaderColor: AppColors.secondaryColor,
        useMaterial3: true,
      ),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: RoutesName.splash,
    );
  }
}
