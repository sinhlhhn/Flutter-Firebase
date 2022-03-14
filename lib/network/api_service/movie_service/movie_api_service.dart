import 'dart:convert';
import 'package:http/http.dart' as http;
import '../app_exception.dart';

/// Thực hiện các `request` lên `server` và xử lý `response` từ server
class MovieApiService {
  final String _baseUrl = "http://api.themoviedb.org/3/";

  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      final responseJson = _returnResponse(response);
      return responseJson;
    } catch (e) {
      throw FetchDataException("No internet");
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
