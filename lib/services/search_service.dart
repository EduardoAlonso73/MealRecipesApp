import 'package:http/http.dart' as http;
import 'package:meal_recipes_app/utils/data_source.dart';
import 'package:meal_recipes_app/utils/safe_api.dart';
import '../models/meal.dart';
import '../models/meal_dto.dart';
import '../utils/constants.dart';

class SearchService {
  Future<DataSource<List<Meal>?>> searchMeal(String meal) async {
    final url = Uri.https(baseApi, "/api/json/v1/1/search.php", {"s": meal});
    return safeApi(
        url: url,
        fromJson: (responseBody) {
          final response = MealDto.fromJson(responseBody).meals;
          return response;
        });
  }
}
