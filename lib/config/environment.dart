import 'package:flutter_black_white/providers/maplist_provider.dart';
import 'package:http/http.dart';


const kBaseUrl = 'api.repliers.io';
const kRepliersCdn = 'https://cdn.repliers.io/';

final String kMaptilerUrl = 'https://api.maptiler.com/maps/basic-v2/{z}/{x}/{y}.png?key=${MapListProvider().getApiKey}';
String processResponse(Response response) {
  if (response.statusCode == 200 || response.statusCode == 201) {
    return response.body;
  } else if (response.statusCode == 400) {
    throw Exception("Bad request");
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized");
  } else if (response.statusCode == 403) {
    throw Exception("Forbidden");
  } else if (response.statusCode == 404) {
    throw Exception("Not found");
  } else if (response.statusCode == 405) {
    throw Exception("Method not allowed");
  } else if (response.statusCode == 500) {
    throw Exception("Internal server error");
  } else if (response.statusCode == 502) {
    throw Exception("Bad gateway");
  } else if (response.statusCode == 503) {
    throw Exception("Service unavailable");
  } else {
    throw Exception("Unknown response status");
  }
}
