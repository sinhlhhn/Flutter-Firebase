import 'package:simple_app/network/firebase/authentication_status.dart';

class AuthenticationException {
  static AuthResultStatus _handleException(e) {
    switch (e.code) {
      case "ERROR_INVALID_EMAIL":
        return AuthResultStatus.invalidEmail;
      case "ERROR_WRONG_PASSWORD":
        return AuthResultStatus.wrongPassword;
      case "ERROR_USER_NOT_FOUND":
        return AuthResultStatus.userNotFound;
      case "ERROR_USER_DISABLED":
        return AuthResultStatus.userDisabled;
      case "ERROR_TOO_MANY_REQUESTS":
        return AuthResultStatus.tooManyRequests;
      case "ERROR_OPERATION_NOT_ALLOWED":
        return AuthResultStatus.operationNotAllowed;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return AuthResultStatus.emailAlreadyExists;
      default:
        return AuthResultStatus.undefined;
    }
  }

  static String generateExceptionMessage(e) {
    AuthResultStatus exceptionCode = _handleException(e);
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        return "Your email address appears to be malformed.";
      case AuthResultStatus.wrongPassword:
        return "Your password is wrong.";
      case AuthResultStatus.userNotFound:
        return "User with this email doesn't exist.";
      case AuthResultStatus.userDisabled:
        return "User with this email has been disabled.";
      case AuthResultStatus.tooManyRequests:
        return "Too many requests. Try again later.";
      case AuthResultStatus.operationNotAllowed:
        return "Signing in with Email and Password is not enabled.";
      case AuthResultStatus.emailAlreadyExists:
        return "The email has already been registered. Please login or reset your password.";
      default:
        return "An undefined Error happened.";
    }
  }
}
