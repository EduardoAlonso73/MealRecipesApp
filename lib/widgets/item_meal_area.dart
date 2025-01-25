import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_route.dart';

class ItemMealArea extends StatelessWidget {
  final String idMeal;
  final String image;
  final String name;

  const ItemMealArea({
    super.key,
    required this.idMeal,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      height: 240,
      width: 200,
      child: Material(
        elevation: 3.0,
        color:  Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            _buildImage(context, idMeal, image),
            SizedBox(height: 10),
            _buildTitle(name),
          ],
        ),
      ),
    );
  }
}

Widget _buildImage(BuildContext context, String idMeal, String image) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(
      context,
      AppRoute.details.route,
      arguments: idMeal,
    ),
    child: Hero(
      tag: idMeal,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: FadeInImage(
          fit: BoxFit.cover,
          width: double.infinity,
          height: 170,
          placeholder: const AssetImage("assets/load_meal.png"),
          image: NetworkImage(image),
        ),
      ),
    ),
  );
}

Widget _buildTitle(String name) {
  return Padding(
    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5),
    child: Text(
      name,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
