import 'package:flutter/material.dart';

import 'package:meal_recipes_app/screens/category_detail/category_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/category.dart';
import '../../utils/app_route.dart';
import '../../utils/constants.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Category category =
        ModalRoute.of(context)?.settings.arguments as Category;
    return ChangeNotifierProvider(
        create: (context) => CategoryDetailProvider(category.strCategory),
        lazy: false,
        child: _CategoryDetailScaffold(category: category));
  }
}

class _CategoryDetailScaffold extends StatelessWidget {
  final Category category;

  const _CategoryDetailScaffold({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<CategoryDetailProvider>(context);
    final uiState = detailProvider.stateMealByCategoryList;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: CustomScrollView(slivers: [
          _MyAppBar(
            id: category.idCategory,
            title: category.strCategory,
            description: category.strCategoryDescription,
            image: category.strCategoryThumb,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            if (uiState.loader)
              _shimmerLoader(context)
            else
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: List.generate(uiState.data?.length ?? 0, (index) {
                  return ItemMealCategory(
                      idMeal: uiState.data?[index].idMeal ?? emptyString,
                      image: uiState.data?[index].strMealThumb ?? defaultImage,
                      name: uiState.data?[index].strMeal ?? emptyString);
                }),
              )
          ]))
        ]));
  }
}

class ItemMealCategory extends StatelessWidget {
  final String idMeal;
  final String image;
  final String name;

  const ItemMealCategory({
    super.key,
    required this.idMeal,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: 200,
      child: Material(
        elevation: 3.0,
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImage(context, idMeal, image),
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        child: FadeInImage(
          fit: BoxFit.cover,
          width: double.infinity,
          height: 130,
          placeholder: const AssetImage("assets/load_meal.png"),
          image: NetworkImage(image),
        ),
      ),
    ),
  );
}

Widget _buildTitle(String name) {
  return Flexible(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 5),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    ),
  );
}

Widget _backgroundImage(String id, String image) {
  return Hero(
    tag: id,
    child: FadeInImage.assetNetwork(
      placeholder: "assets/load_meal.png",
      image: image,
      fit: BoxFit.cover,
    ),
  );
}

class _MyAppBar extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String image;

  const _MyAppBar({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.orange,
      expandedHeight: 300,
      floating: false,
      pinned: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double appBarHeight = constraints.biggest.height;
          final bool showFlexibleTitle = appBarHeight > kToolbarHeight + 70;
          return FlexibleSpaceBar(
            centerTitle: true,
            background: Stack(
              fit: StackFit.expand,
              children: [
                _backgroundImage(id, image),
                if (showFlexibleTitle) _headerPositioned(size),
                _descriptionPositioned(size, description)
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _headerPositioned(Size size) {
  return Positioned(
    top: 0,
    left: 0,
    child: Container(
      height: 150,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.transparent, Colors.black87],
        ),
      ),
    ),
  );
}

Widget _descriptionPositioned(Size size, String description) {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      height: 200,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black87],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            description,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

Widget _shimmerLoader(context) {
  final baseColor = Theme.of(context).canvasColor;
  final highlightColor = Theme.of(context).highlightColor;
  final contentColor = Theme.of(context).cardColor;
  return GridView.count(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(10),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 2,
    children: List.generate(20, (index) {
      return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
              decoration: BoxDecoration(
                color: contentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 220,
              width: 200));
    }),
  );
}
