import 'package:flutter/material.dart';
import 'package:meal_recipes_app/models/category.dart';
import 'package:meal_recipes_app/utils/ui_state.dart';
import 'package:meal_recipes_app/widgets/item_category.dart';
import 'package:shimmer/shimmer.dart';

class CategorySlider extends StatelessWidget {
  final UIState<List<Category>> uiStateCategory;
  final String? title;

  const CategorySlider({super.key, required this.uiStateCategory, this.title});

  @override
  Widget build(BuildContext context) {
    if (uiStateCategory.loader) return _shimmerLoader(context);

    return SizedBox(
      width: double.infinity,
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: uiStateCategory.data!.length,
                itemBuilder: (_, int index) => ItemCategory(
                      category: uiStateCategory.data?[index],
                    )),
          )
        ],
      ),
    );
  }
}

Widget _shimmerLoader(context) {
  final baseColor = Theme.of(context).canvasColor;
  final highlightColor = Theme.of(context).highlightColor;
  final contentColor = Theme.of(context).cardColor;
  return SizedBox(
    width: double.infinity,
    height: 180,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                color: contentColor,
                width: 120,
                height: 30,
              )),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (_, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: contentColor,
                              borderRadius: BorderRadius.circular(100),
                            )),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            color: contentColor,
                            width: 80,
                            height: 20,
                          )),
                    ],
                  ),
                );
              }),
        )
      ],
    ),
  );
}
