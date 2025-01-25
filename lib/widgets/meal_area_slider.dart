import 'package:flutter/material.dart';
import 'package:meal_recipes_app/models/category.dart';
import 'package:meal_recipes_app/models/meal_area.dart';
import 'package:meal_recipes_app/models/meal_area.dart';
import 'package:meal_recipes_app/utils/constants.dart';
import 'package:meal_recipes_app/utils/ui_state.dart';
import 'package:meal_recipes_app/widgets/item_category.dart';
import 'package:meal_recipes_app/widgets/item_meal_area.dart';
import 'package:shimmer/shimmer.dart';

class MealAreaSlider extends StatelessWidget {
  final UIState<List<MealArea>> mealAreaList;

  const MealAreaSlider({super.key, required this.mealAreaList});

  @override
  Widget build(BuildContext context) {
    if (mealAreaList.loader) {
      return _shimmerLoader(context);
    }
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Expanded(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mealAreaList.data?.length,
            itemBuilder: (_, int index) => ItemMealArea(
                idMeal: mealAreaList.data?[index].idMeal ?? emptyString,
                image: mealAreaList.data?[index].strMealThumb ?? defaultImage,
                name: mealAreaList.data?[index].strMeal ?? emptyString)),
      ),
    );
  }
}

Widget _shimmerLoader(context) {
  final baseColor = Theme.of(context).canvasColor;
  final highlightColor = Theme.of(context).highlightColor;
  final contentColor = Theme.of(context).cardColor;

  return SizedBox(
    width: double.infinity,
    height: 230,
    child: Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (_, int index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                        height: 220,
                        width: 200,
                        decoration: BoxDecoration(
                          color: contentColor,
                          borderRadius: BorderRadius.circular(20),
                        )),
                  )
                ],
              ),
            );
          }),
    ),
  );
}
