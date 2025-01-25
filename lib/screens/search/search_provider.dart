import 'dart:async';


import 'package:flutter/material.dart';
import 'package:meal_recipes_app/utils/constants.dart';
import 'package:meal_recipes_app/utils/ui_state.dart';

import '../../models/meal.dart';
import '../../services/search_service.dart';
import '../../utils/debouncer.dart';

class SearchProvider extends ChangeNotifier {
  final _searchService = SearchService();

  final Debouncer debouncer =
      Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<UIState<List<Meal>>> _suggestionStreamController =
      StreamController.broadcast();

  Stream<UIState<List<Meal>>> get suggestionStream =>
      _suggestionStreamController.stream;

  Future<UIState<List<Meal>>> _searchMovies(String query) async {
    final result = await _searchService.searchMeal(query);

    if (result.error == null) {
      return UIState(data: result.data, error: null, loader: false);
    } else {
      return UIState(
          data: null, error: "Error when search meal ", loader: false);
    }
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = emptyString;
    debouncer.onValue = (value) async {
      final result = await _searchMovies(value);
      _suggestionStreamController.add(result);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
