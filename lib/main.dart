import 'package:flutter/material.dart';
import 'package:meal_recipes_app/screens/category_detail/category_detail_screen.dart';
import 'package:meal_recipes_app/screens/meal_detail/detail_screen.dart';
import 'package:meal_recipes_app/screens/home/home_screen.dart';
import 'package:meal_recipes_app/screens/splash/splash_screen.dart';
import 'package:meal_recipes_app/utils/theme_provider.dart';
import 'package:meal_recipes_app/utils/app_route.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoute.splash.route,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        routes: {
          AppRoute.splash.route: (_) => const SplashScreen(),
          AppRoute.home.route: (_) => const HomeScreen(),
          AppRoute.categoryDetail.route: (_) => const CategoryDetailScreen(),
          AppRoute.details.route: (_) => const DetailScreen()
        });
  }
}
