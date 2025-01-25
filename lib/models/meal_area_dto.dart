import 'dart:convert';

import 'meal_area.dart';

class MealAreaDto {
  List<MealArea> meals;

  MealAreaDto({
    required this.meals,
  });

  factory MealAreaDto.fromJson(String str) =>
      MealAreaDto.fromMap(json.decode(str));


  factory MealAreaDto.fromMap(Map<String, dynamic> json) => MealAreaDto(
        meals:
            List<MealArea>.from(json["meals"].map((x) => MealArea.fromMap(x))),
      );

}

