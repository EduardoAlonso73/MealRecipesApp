import 'package:flutter/material.dart';
import 'package:meal_recipes_app/models/category.dart';
import 'package:meal_recipes_app/widgets/item_category.dart';

/*class IngredientsList extends StatelessWidget {
  final List<Map<String, String>> ingredients;
  final String? title;

  const IngredientsList({super.key, required this.ingredients, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: ingredients.length,
                itemBuilder: (_, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(ingredients[index].keys.first),
                              Text(ingredients[index].values.first)
                            ]),
                        if (index != ingredients.length - 1)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            width: double.infinity,
                            color: Colors.grey,
                            height: 1,
                          )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}*/

class IngredientsList extends StatelessWidget {
  final List<Map<String, String>> ingredients;
  final String? title;

  const IngredientsList({super.key, required this.ingredients, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color:  Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10,),
                child: Text(
                  title!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ingredients.length,
                itemBuilder: (_, int index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(ingredients[index].keys.first,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600)),
                              Text(ingredients[index].values.first,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600))
                            ]),
                        if (index != ingredients.length - 1)
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              width: double.infinity,
                              color: Colors.grey,
                              height: 0.2)
                      ]));
                }),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }
}
