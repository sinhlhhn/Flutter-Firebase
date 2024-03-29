/// chuyển `errors` nhận được từ `server` thành `errors` dễ hiểu hơn cho `user`
class AppException {
  final String _message;
  final String _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix + $_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, "Error During communication: ");
}

class BadRequestException extends AppException {
  BadRequestException(String message) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String message) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException(String message) : super(message, "Invalid Input: ");
}
