import 'dart:convert';

import 'package:flutter_black_white/models/base_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class HttpProcessResponse {
  static Map<String, String> get headersDefault {
    return {'Content-Type': "application/json", 'Accept': "application/json"};
  }

  static final String _serverUrl = dotenv.get("BASE_API_SERVER");
  static const String login = "authentication";
  static const String updatePassword = "authentication/password";
  static const String deleteAccount = "account/";

  static Future<BaseResponseModel<T>> post<T>(String endPoint, {Object? body}) async {
    late Response response;

    try {
      final url = Uri.http(_serverUrl, endPoint);
      response = await http.post(url, headers: headersDefault, body: jsonEncode(body));

      return processResponseError<T>(response);
    } catch (_) {
      return BaseResponseModel<T>(error: "Something went wrong", message: "Request failed", data: null);
      // return processResponseError(response);
    }
  }

  static Future<BaseResponseModel<T>> patch<T>(String endPoint, {Object? body}) async {
    late Response response;

    try {
      final url = Uri.http(_serverUrl, endPoint);
      response = await http.patch(url, headers: headersDefault, body: jsonEncode(body));

      return processResponseError<T>(response);
    } catch (_) {
      return BaseResponseModel<T>(error: "Something went wrong", message: "Request failed", data: null);
      // return processResponseError(response);
    }
  }  


  static Future<BaseResponseModel<T>> delete<T>(String endPoint, {Object? body}) async {
    late Response response;

    try {
      final url = Uri.http(_serverUrl, endPoint);
      response = await http.delete(url, headers: headersDefault, body: jsonEncode(body));

      return processResponseError<T>(response);
    } catch (_) {
      return BaseResponseModel<T>(error: "Something went wrong", message: "Request failed", data: null);
      // return processResponseError(response);
    }
  }    

  static BaseResponseModel<T> processResponseError<T>(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return BaseResponseModel<T>.fromJson(json.decode(response.body));
    } else if (response.statusCode == 204) {
      return BaseResponseModel<T>.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      return BaseResponseModel<T>.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      return BaseResponseModel<T>.fromJson(json.decode(response.body));
    } else if (response.statusCode == 403) {
      return BaseResponseModel<T>.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return BaseResponseModel<T>.fromJson(json.decode(response.body));
    } else if (response.statusCode == 405) {
      return BaseResponseModel<T>.fromJson(json.decode(response.body));
    } else if (response.statusCode == 500) {
      return BaseResponseModel<T>.fromJson(json.decode(response.body));
    } else if (response.statusCode == 502) {
      return BaseResponseModel<T>.fromJson(json.decode(response.body));
    } else if (response.statusCode == 503) {
      return BaseResponseModel<T>.fromJson(json.decode(response.body));
    } else {
      return BaseResponseModel<T>(error: "Something went wrong", message: "Request failed", data: null);
    }
  }
}
