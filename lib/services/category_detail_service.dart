import 'package:http/http.dart' as http;
import 'package:meal_recipes_app/models/meal_area.dart';
import 'package:meal_recipes_app/utils/data_source.dart';
import 'package:meal_recipes_app/utils/safe_api.dart';
import '../models/meal.dart';
import '../models/meal_area_dto.dart';
import '../utils/constants.dart';

class CategoryDetailService {
  Future<DataSource<List<MealArea>?>> getMeatByCategory(String category) async {
    final url =
        Uri.https(baseApi, "/api/json/v1/1/filter.php", {"c": category});
    return safeApi(
        url: url,
        fromJson: (responseBody) {
          final response = MealAreaDto.fromJson(responseBody).meals;
          return response;
        });
  }
}
