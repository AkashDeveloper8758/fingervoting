import 'dart:convert';

import 'package:http/http.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);
  static const String baseUrl = 'https://fingervoting.herokuapp.com/';
  // static const String testUrl = 'http://localhost:3000/';
  static const String testUrl = 'http://192.168.1.2:3000/';
  static const coreUrl = baseUrl;

  dynamic get(String path) async {
    // print('final Path : ${coreUrl}$path');
    final response = await _client.get(Uri.parse('$coreUrl$path'), headers: {
      'Content-Type': 'application/json',
    }).timeout(const Duration(seconds: 20));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      // print('get requested: $responseBody');
      // print('response status : ${response.statusCode}');
      return responseBody;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic patch(String path) async {
    final response = await _client.patch(Uri.parse('$coreUrl$path'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic put(String path, dynamic body) async {
    var header = {
      'Content-Type': 'application/json',
    };

    final response = await _client.put(
      Uri.parse('$coreUrl$path'),
      headers: header,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(String path, dynamic body) async {
    var header = {
      'Content-Type': 'application/json',
    };
    final response = await _client.post(
      Uri.parse('$coreUrl$path'),
      headers: header,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }
}
