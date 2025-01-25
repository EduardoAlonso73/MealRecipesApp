import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_recipes_app/screens/home/home_provider.dart';
import 'package:meal_recipes_app/widgets/category_slider.dart';
import 'package:meal_recipes_app/widgets/meal_area_slider.dart';
import 'package:provider/provider.dart';

import '../../widgets/card_meal.dart';
import '../../widgets/nationalities_slider.dart';
import '../../widgets/search_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomeProvider(),
        lazy: false,
        child: _HomeScaffold());
  }
}

class _HomeScaffold extends StatelessWidget {
  const _HomeScaffold();

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Home",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 25),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchView(),
            CardMeal(uiStateMeal: homeProvider.mealRandom),
            SizedBox(height: 20),
            CategorySlider(
                uiStateCategory: homeProvider.uiStateCategory,
                title: "Category"),
            SizedBox(height: 20),
            NationalitiesSlider(),
            MealAreaSlider(mealAreaList: homeProvider.stateMealAreaList),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
