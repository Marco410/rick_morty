import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rick_morty/config/constants/constants.dart';

Future<String?> httpBase({
  required String type,
  required String path,
  Object? body,
  Map<String, String>? headers,
  Map<String, String>? params,
  Map<String, String>? bodyMultipart,
}) async {
  try {
    http.Response response = http.Response("", 500);
    var url = Uri.https(baseUrl, path, params);

    headers ??= {};
    headers["Content-type"] = "application/json";
    headers["Accept"] = "*/*";

    late String data;
    switch (type) {
      case "GET":
        response = await http.get(url, headers: headers);
        data = response.body;
        break;
    }

    return data;
  } catch (e) {
    return null;
  }
}
