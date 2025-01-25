import 'package:flutter/material.dart';

import '../screens/search/search_screen.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showSearch(context: context, delegate: MealSearchDelegate()),
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        decoration: BoxDecoration(
            color: const Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: 18,
              child: Icon(
                Icons.search_outlined,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 30),
            Text(
              "Search",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
