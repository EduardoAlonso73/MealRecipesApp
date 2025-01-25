import 'dart:convert';

class MealArea {
  String strMeal;
  String strMealThumb;
  String idMeal;

  MealArea({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory MealArea.fromJson(String str) => MealArea.fromMap(json.decode(str));

  factory MealArea.fromMap(Map<String, dynamic> json) => MealArea(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );
}
