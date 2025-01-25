import 'package:http/http.dart' as http;
import 'package:meal_recipes_app/utils/data_source.dart';
import '../models/meal.dart';
import '../models/meal_dto.dart';
import '../utils/constants.dart';
import '../utils/safe_api.dart';

class DetailService {
  Future<DataSource<Meal?>> getDetailMeal(String id) async {
    final url = Uri.https(baseApi, "/api/json/v1/1/lookup.php", {"i": id});

    return safeApi(
        url: url,
        fromJson: (responseBody) {
          final response = MealDto.fromJson(responseBody).meals;
          print("GET DETAIL MEAL REPOPNSE  ------->  $response");
          return response.first;
        });
  }
}
