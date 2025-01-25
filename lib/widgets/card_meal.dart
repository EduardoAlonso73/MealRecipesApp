import 'package:flutter/material.dart';
import 'package:meal_recipes_app/models/meal.dart';
import 'package:meal_recipes_app/utils/ui_state.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_route.dart';
import '../utils/constants.dart';

class CardMeal extends StatelessWidget {
  final UIState<Meal?> uiStateMeal;

  const CardMeal({
    super.key,
    required this.uiStateMeal,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (uiStateMeal.loader) return _shimmerLoader(context,size);
    if (uiStateMeal.error != null) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.3,
        child: const Text("Meal no found :("),
      );
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      width: double.infinity,
      height: size.height * 0.3,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRoute.details.route,
            arguments: uiStateMeal.data?.idMeal ?? emptyString),
        child: Hero(
          tag: emptyString,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(children: [
              FadeInImage(
                  height: size.height * 0.3,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: const AssetImage("assets/load_meal.png"),
                  image: NetworkImage(uiStateMeal.data?.strMealThumb ?? defaultImage)),
              Container(
                color: Colors.black38,
              ),
              Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width - 80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            uiStateMeal.data?.strArea ?? "",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            uiStateMeal.data?.strMeal.toUpperCase() ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10)
                        ],
                      ),
                    ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}

Widget _shimmerLoader(context,Size size) {
  final baseColor = Theme.of(context).canvasColor;
  final highlightColor = Theme.of(context).highlightColor;
  final contentColor = Theme.of(context).cardColor;
  return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        width: double.infinity,
        height: size.height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: contentColor,
        ),
      ));
}
