abstract class DataResponse<T> {}

class Success<T> extends DataResponse<T> {
  final T data;
  Success(this.data);
}

class Failure<T> extends DataResponse<T> {
  final String message;
  final int? statusCode;
  Failure(this.message, {this.statusCode});
}
