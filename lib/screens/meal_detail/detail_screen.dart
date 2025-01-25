import 'package:flutter/material.dart';
import 'package:meal_recipes_app/models/meal.dart';
import 'package:meal_recipes_app/screens/meal_detail/detail_provider.dart';
import 'package:meal_recipes_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/ingredients_list.dart';
import '../../utils/open_link.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String idMeal = ModalRoute.of(context)!.settings.arguments as String;
    return ChangeNotifierProvider(
        create: (context) => DetailProvider(idMeal),
        lazy: false,
        child: _DetailsScaffold());
  }
}

class _DetailsScaffold extends StatelessWidget {
  const _DetailsScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailProvider>(context);
    final uiState = detailProvider.stateMealDetail;
    if (detailProvider.stateMealDetail.loader) return _ShimmerLoader();
    return Scaffold(
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(slivers: [
        _MyAppBar(meal: uiState.data),
        SliverList(
            delegate: SliverChildListDelegate([
          _InstructionsSection(
            category: uiState.data?.strCategory ?? emptyString,
            instructions: uiState.data?.strInstructions ?? emptyString,
            stepInstSource: uiState.data?.strSource ?? emptyString,
          ),
          IngredientsList(
            title: "Ingredients",
            ingredients: uiState.data?.getIngredients ?? List.empty(),
          )
        ]))
      ]),
    );
  }
}

class _InstructionsSection extends StatelessWidget {
  final String instructions;
  final String stepInstSource;
  final String category;

  const _InstructionsSection(
      {super.key,
      required this.instructions,
      required this.category,
      required this.stepInstSource});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Instructions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 5),
                IconButton(
                    onPressed: () => openLink(stepInstSource),
                    icon: Icon(
                      Icons.link_outlined,
                      color: Colors.grey,
                    ))
              ]),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.orange),
                child: Text(
                  category,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Text(instructions, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  final Meal? meal;

  const _MyAppBar({super.key, this.meal});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final detailProvider = Provider.of<DetailProvider>(context);
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.orange,
      expandedHeight: size.height * 0.5,
      floating: false,
      pinned: true,
      title: Text(
        detailProvider.isTitleVisible
            ? emptyString
            : meal?.strMeal ?? emptyString,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            detailProvider.updateVisibility(showFlexibleTitle);
          });
          return FlexibleSpaceBar(
            centerTitle: true,
            background: Stack(
              fit: StackFit.expand,
              children: [
                FadeInImage(
                    fit: BoxFit.cover,
                    height: double.infinity,
                    placeholder: const AssetImage("assets/load_meal.png"),
                    image: NetworkImage(meal?.strMealThumb ?? defaultImage)),
                if (showFlexibleTitle) _headerPositioned(size),
                _TitlePositioned(
                  title: meal?.strMeal ?? emptyString,
                  area: meal?.strArea ?? emptyString,
                  videoLink: meal?.strYoutube ?? emptyString,
                )
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

class _TitlePositioned extends StatelessWidget {
  final String title;
  final String area;
  final String videoLink;

  const _TitlePositioned(
      {super.key,
      required this.title,
      required this.area,
      required this.videoLink});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          width: size.width,
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black87],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(area,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: size.width - 130),
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (videoLink.isNotEmpty)
                        IconButton(
                            onPressed: () {
                              openLink(videoLink);
                            },
                            icon: Icon(
                              Icons.play_circle,
                              size: 35,
                              color: Colors.white,
                            ))
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ));
  }
}

class _ShimmerLoader extends StatelessWidget {
  const _ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).canvasColor;
    final highlightColor = Theme.of(context).highlightColor;
    final contentColor = Theme.of(context).cardColor;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: double.infinity,
              height: size.height * 0.5,
              color: contentColor,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 100,
                    height: 30,
                    color: contentColor,
                  )),
              Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: contentColor,
                    )),
              )
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 15,
                itemBuilder: (_, int index) => Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      height: 10,
                      color: contentColor,
                    ))),
          )
        ],
      ),
    );
  }
}
