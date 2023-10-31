import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static Future<Map<String, dynamic>> getData(String url) async {
    final Uri uri = Uri.parse(url);
    final response = await http.get(uri);

    final int status = response.statusCode;
    final String content = response.body;

    bool isOk = status == 200;

    if (isOk) {
      return jsonDecode(content);
    } else {
      throw Exception("Falha ao baixar dados: $status");
    }
  }
}
