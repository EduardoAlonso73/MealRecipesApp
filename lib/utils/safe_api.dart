import 'package:http/http.dart' as http;

import 'data_source.dart';

Future<DataSource<T>> safeApi<T>({
  required Uri url,
  required T Function(String) fromJson,
}) async {
  try {
    final response = await http.get(url);
    switch (response.statusCode) {
      case 200:
        final responseBody = response.body;
        return DataSource(data: fromJson(responseBody), error: null);
      default:
        return _handleHttpError(response.statusCode);
    }
  } catch (e) {
    return DataSource(data: null, error: NetworkError(type: ErrorType.UNKNOWN));
  }
}

DataSource<T> _handleHttpError<T>(int statusCode) {
  if (statusCode >= 400 && statusCode <= 499) {
    return DataSource(
        data: null, error: NetworkError(type: ErrorType.ERROR_CLIENT));
  } else if (statusCode >= 500 && statusCode <= 599) {
    return DataSource(
        data: null, error: NetworkError(type: ErrorType.SERVER_ERROR));
  } else {
    return DataSource(data: null, error: NetworkError(type: ErrorType.UNKNOWN));
  }
}
