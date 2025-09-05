abstract class Response<T> {}

class SuccessResponse<T> extends Response<T> {
  final T data;
  SuccessResponse(this.data);
}

class FailureResponse<T> extends Response<T> {
  final String message;
  final int? statusCode;
  FailureResponse(this.message, {this.statusCode});
}
