abstract class UserRemoteResponse<T> {}

class RemoteSuccess<T> extends UserRemoteResponse<T> {
  final T data;
  RemoteSuccess(this.data);
}

class RemoteFailure<T> extends UserRemoteResponse<T> {
  final String message;
  final int? statusCode;
  RemoteFailure(this.message, {this.statusCode});
}
