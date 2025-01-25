import 'dart:convert';

import 'category.dart';

class CategoriesDto {
  List<Category> categories;

  CategoriesDto({
    required this.categories,
  });

  factory CategoriesDto.fromJson(String str) => CategoriesDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesDto.fromMap(Map<String, dynamic> json) => CategoriesDto(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
  };
}