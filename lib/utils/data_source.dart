abstract class Error {}

abstract class DataError implements Error {}

class NetworkError extends DataError {
  final ErrorType type;
  final String? message;

  NetworkError({required this.type, this.message});
}

enum ErrorType { ERROR_CLIENT, SERVER_ERROR, SERIALIZATION_ERROR, UNKNOWN }

enum LocalError implements DataError { DISK_FULL, PERMISSION_DENIED }

class DataSource<T> {
  final T? data;
  final Error? error;

  DataSource({this.data, this.error});
}
