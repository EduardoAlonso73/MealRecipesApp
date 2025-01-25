import 'dart:convert';

import 'meal.dart';

class MealDto {
  List<Meal> meals;

  MealDto({
    required this.meals,
  });

  factory MealDto.fromJson(String str) => MealDto.fromMap(json.decode(str));

  factory MealDto.fromMap(Map<String, dynamic> json) => MealDto(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromMap(x))),
      );
}

