import 'package:flutter/material.dart';
import 'package:meal_recipes_app/utils/data_source.dart';
import 'package:meal_recipes_app/utils/ui_state.dart';

import '../../models/meal.dart';
import '../../services/detail_service.dart';

class DetailProvider extends ChangeNotifier {
  final _detailService = DetailService();
  Map<String, Meal?> mealDetailCatch = {};
  UIState<Meal?> stateMealDetail = UIState(data: null);
  bool _isTitleVisible = true;

  bool get isTitleVisible => _isTitleVisible;

  final String mealId;

  void updateVisibility(bool isVisible) {
    if (_isTitleVisible != isVisible) {
      _isTitleVisible = isVisible;
      notifyListeners();
    }
  }

  DetailProvider(this.mealId) {
    _getDetailsMeal(mealId);
  }

  _getDetailsMeal(String id) async {
    if (mealDetailCatch.containsKey(id)) {
      stateMealDetail = stateMealDetail =
          UIState(data: mealDetailCatch[id], error: null, loader: false);
      notifyListeners();
    } else {
      final DataSource<Meal?> result = await _detailService.getDetailMeal(id);
      if (result.error == null) {
        stateMealDetail =
            UIState(data: result.data, error: null, loader: false);
        mealDetailCatch[id] = result.data;
        notifyListeners();
      } else {
        mealDetailCatch.clear();
        stateMealDetail = UIState(
            data: null, error: "Ooops! Something went wrong", loader: false);
      }
    }
  }
}
