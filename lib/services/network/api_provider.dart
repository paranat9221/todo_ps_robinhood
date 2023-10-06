import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_request_representable.dart';

class APIProvider {
  static const _requestTimeOut = Duration(seconds: 25);
  static final _singleton = APIProvider();

  static APIProvider get instance => _singleton;

  Future request(APIRequestRepresentable request) async {
    try {
      final originalUrl = Uri.parse(request.url);
      final url = Uri(
        scheme: originalUrl.scheme,
        host: originalUrl.host,
        path: originalUrl.path,
        queryParameters: request.query,
      );

      if (request.method == HTTPMethod.post) {
        final http.Response response = await http
            .post(
              url,
              headers: request.headers,
              body: jsonEncode(request.body),
            )
            .timeout(_requestTimeOut);
        return _returnResponse(response);
      } else if (request.method == HTTPMethod.get) {
        final http.Response response = await http
            .get(
              url,
              headers: request.headers,
            )
            .timeout(_requestTimeOut);
        return _returnResponse(response);
      }
      // } on TimeoutException catch (_) {
      //   throw TimeOutException();
    } on SocketException {
      throw const SocketException("");
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 401:
      case 400:
      case 403:
      case 404:
      case 409:
      // case 500:
      //   throw CustomException(
      //     title: "${AppTextError.errorDefaultTitle} : ${response.statusCode}",
      //     message: AppTextError.errorDefaultMessage,
      //   );
      // default:
      //   throw NetworkException();
    }
  }
}
