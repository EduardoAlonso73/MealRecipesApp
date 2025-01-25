import 'package:flutter/material.dart';
import 'package:meal_recipes_app/models/meal_area.dart';
import 'package:meal_recipes_app/utils/data_source.dart';
import 'package:meal_recipes_app/utils/ui_state.dart';
import '../../services/category_detail_service.dart';

class CategoryDetailProvider extends ChangeNotifier {
  final _categoryDetailService = CategoryDetailService();
  UIState<List<MealArea>> stateMealByCategoryList = UIState(data: []);
  Map<String, List<MealArea>?> mealByCategoryListCatch = {};

  final String category;

  CategoryDetailProvider(this.category) {
    _getMeatByCategory(category);
  }

  _getMeatByCategory(String category) async {
    if (mealByCategoryListCatch.containsKey(category)) {
      stateMealByCategoryList = UIState(data: mealByCategoryListCatch[category]!, error: null, loader: false);
      notifyListeners();
    } else {
      final DataSource<List<MealArea>?> result = await _categoryDetailService.getMeatByCategory(category);
      if (result.error == null) {
        final data = result.data ?? List.empty();
        stateMealByCategoryList = UIState(data: data, error: null, loader: false);
        mealByCategoryListCatch[category] = data;
        notifyListeners();
      } else {
        stateMealByCategoryList = UIState(data: [], error: "Ooops! Something went wrong", loader: false);
        mealByCategoryListCatch.clear();

      }
    }
  }
}
