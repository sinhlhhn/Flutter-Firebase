import 'package:equatable/equatable.dart';

enum APIResponseStatus { loading, completed, error }

abstract class APIResponse<T> extends Equatable {
  final APIResponseStatus? status;
  final T? data;
  final String message;

  const APIResponse({
    this.status,
    this.data,
    this.message = "",
  });

  const APIResponse.loading(String message)
      : this(status: APIResponseStatus.loading, message: message);
  const APIResponse.completed(T data)
      : this(status: APIResponseStatus.completed, data: data);
  const APIResponse.error(String message)
      : this(status: APIResponseStatus.error, message: message);

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

  @override
  List<Object?> get props => [status];
}
