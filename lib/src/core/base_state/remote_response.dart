abstract class RemoteResponse<T> {}

class RemoteSuccess<T> extends RemoteResponse<T> {
  final T data;
  RemoteSuccess(this.data);
}

class RemoteFailure<T> extends RemoteResponse<T> {
  final String message;
  final int? statusCode;
  RemoteFailure(this.message, {this.statusCode});
}
