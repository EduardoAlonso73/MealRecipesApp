import 'package:flutter/material.dart';
import 'package:meal_recipes_app/models/meal_area.dart';
import 'package:meal_recipes_app/services/home_service.dart';
import 'package:meal_recipes_app/services/search_service.dart';
import 'package:meal_recipes_app/utils/ui_state.dart';

import '../../models/category.dart';
import '../../models/meal.dart';
import '../../services/detail_service.dart';
import '../../utils/data_source.dart';

class HomeProvider extends ChangeNotifier {
  final _homeService = HomeService();
  UIState<Meal?> mealRandom = UIState(data: null);
  UIState<List<Category>> uiStateCategory = UIState(data: []);
  UIState<List<MealArea>> stateMealAreaList = UIState(data: []);
  String _selectedChoiceTap = "Mexican";

  HomeProvider() {
    _getRandomMeal();
    _getAllCategoryMeal();
    _getMealByArea(_selectedChoiceTap);
  }

  String get selectedChoiceTap => _selectedChoiceTap;

  void selectChoice(String value) {
    _selectedChoiceTap = value;
    _getMealByArea(value);
    stateMealAreaList = UIState(data: [], loader: true, error: null);
    notifyListeners();
  }

  _getMealByArea(String area) async {
    final DataSource<List<MealArea>?> result =
        await _homeService.getAllMealByArea(area);

    if (result.error == null) {
      final data = result.data ?? List.empty();
      stateMealAreaList = UIState(data: data, loader: false, error: null);
      notifyListeners();
    } else {
      stateMealAreaList = UIState(data: [], loader: false, error: "Ooops! Something went wrong");
    }
  }

  _getRandomMeal() async {
    final DataSource<Meal?> result = await _homeService.getRandomMeal();
    if (result.error == null) {
      mealRandom = UIState(data: result.data, loader: false, error: null);
      notifyListeners();
    } else {
      mealRandom = UIState(
          data: null, loader: false, error: "Ooops! Something went wrong");
      notifyListeners();
    }
  }

  _getAllCategoryMeal() async {
    final DataSource<List<Category>?> result =
        await _homeService.getAllCategoryMeal();

    if (result.error == null) {
      uiStateCategory = UIState(
          data: result.data ?? List.empty(), error: null, loader: false);
      notifyListeners();
    } else {
      uiStateCategory = UIState(
          data: List.empty(),
          error: "Ooops! Something went wrong",
          loader: false);
    }
  }
}
