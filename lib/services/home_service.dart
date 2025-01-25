import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:meal_recipes_app/models/categories_dto.dart';
import 'package:meal_recipes_app/models/category.dart';
import 'package:meal_recipes_app/models/meal_area.dart';
import 'package:meal_recipes_app/models/meal_area_dto.dart';
import '../models/meal.dart';
import '../models/meal_dto.dart';
import '../utils/constants.dart';
import '../utils/data_source.dart';
import '../utils/safe_api.dart';

class HomeService {
  Future<DataSource<Meal?>> getRandomMeal() async {
    final url = Uri.https(baseApi, "/api/json/v1/1/random.php");
    return safeApi(
        url: url,
        fromJson: (responseBody) {
          final meals = MealDto.fromJson(responseBody).meals;
          return meals.first;
        });
  }

  Future<DataSource<List<Category>?>> getAllCategoryMeal() async {
    final url = Uri.https(baseApi, "/api/json/v1/1/categories.php");
    return safeApi(
        url: url,
        fromJson: (responseBody) {
          final response = CategoriesDto.fromJson(responseBody);
          return response.categories;
        });
  }

  Future<DataSource<List<MealArea>?>> getAllMealByArea(String area) async {
    final url = Uri.https(baseApi, "/api/json/v1/1/filter.php", {"a": area});
    return safeApi(
        url: url,
        fromJson: (responseBody) {
          final response = MealAreaDto.fromJson(responseBody);
          return response.meals;
        });
  }
}
