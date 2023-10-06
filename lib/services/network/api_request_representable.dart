import 'package:http/http.dart' as http;

enum HTTPMethod { get, post, delete, put, patch }

extension HTTPMethodFunction on HTTPMethod {
  Function get function {
    switch (this) {
      case HTTPMethod.get:
        return http.get;
      case HTTPMethod.post:
        return http.post;
      case HTTPMethod.delete:
        return http.delete;
      case HTTPMethod.patch:
        return http.patch;
      case HTTPMethod.put:
        return http.put;
    }
  }
}

abstract class APIRequestRepresentable {
  String get url;
  String get endpoint;
  String get path;
  HTTPMethod get method;
  Map<String, String>? get headers;
  Map<String, String>? get query;
  dynamic get body;
  Future request();
}
