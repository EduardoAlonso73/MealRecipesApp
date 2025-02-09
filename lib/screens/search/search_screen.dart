import 'package:flutter/material.dart';
import 'package:meal_recipes_app/screens/search/search_provider.dart';
import 'package:meal_recipes_app/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_route.dart';
import '../../models/meal.dart';
import '../../utils/ui_state.dart';

class MealSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => "Search meal";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => query = emptyString, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return _emptyContainer();
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      child: StreamBuilderSearch(query: query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return _emptyContainer();
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      child: StreamBuilderSearch(query: query),
    );
  }
}

class StreamBuilderSearch extends StatelessWidget {
  final String query;

  const StreamBuilderSearch({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
        stream: searchProvider.suggestionStream,
        builder: (BuildContext context,
            AsyncSnapshot<UIState<List<Meal>>> snapshot) {
          if (!snapshot.hasData && snapshot.data == null) {
            return _emptyContainer();
          }
          final meals = snapshot.data?.data ?? [];
          return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (_, int index) => _MeatItem(meal: meals[index]));
        });
  }
}

class _MeatItem extends StatelessWidget {
  final Meal meal;

  const _MeatItem({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRoute.details.route,
            arguments: meal.idMeal),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage(
                  width: 60,
                  height: 80,
                  placeholder: const AssetImage("assets/load_meal.png"),
                  image: NetworkImage(meal.strMealThumb),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(meal.strMeal,
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 2),
                  Text(meal.strCategory, style: TextStyle(fontSize: 12))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _emptyContainer() {
  return const Center(
      child: FadeInImage(
    width: 90,
    height: 90,
    placeholder: const AssetImage("assets/load_meal.png"),
    fit: BoxFit.cover,
    image: AssetImage("assets/load_meal.png"),
  ));
}
