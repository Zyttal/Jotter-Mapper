import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class JokeController {
  final String _baseURL = "https://api.api-ninjas.com/v1/jokes";

  Future<Map<String, String>> fetchJoke() async {
    final url = Uri.parse(_baseURL);
    final headers = {'X-Api-Key': '${dotenv.env['API_NINJAS_KEY']}'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return {'joke': result[0]['joke']};
    } else {
      print(response);
      throw Exception('Failed to load Quote...');
    }
  }
}
