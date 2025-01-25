import 'package:flutter/material.dart';
import 'package:meal_recipes_app/utils/constants.dart';

import '../models/category.dart';
import '../utils/app_route.dart';

class ItemCategory extends StatelessWidget {
  final Category? category;

  const ItemCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      width: 80,
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, AppRoute.categoryDetail.route,
                arguments: category),
            child: Material(
              elevation: 15,
              color: Colors.white,
              shape: CircleBorder(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Stack(children: [
                  Hero(
                    tag: category?.idCategory ?? emptyString,
                    child: FadeInImage(
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                        placeholder: const AssetImage("assets/load_meal.png"),
                        image: NetworkImage(
                            category?.strCategoryThumb ?? defaultImage)),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            style: TextStyle(fontWeight: FontWeight.w500),
            category?.strCategory ?? emptyString,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
