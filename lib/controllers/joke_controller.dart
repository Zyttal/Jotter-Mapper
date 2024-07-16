import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class JokeController with ChangeNotifier {
  String? joke;
  static void initialize() {
    GetIt.instance.registerSingleton<JokeController>(JokeController());
    instance.fetchJoke();
  }

  static JokeController get instance => GetIt.instance<JokeController>();
  static JokeController get I => GetIt.instance<JokeController>();

  final String _baseURL = "https://api.api-ninjas.com/v1/jokes";

  Future<void> fetchJoke() async {
    final url = Uri.parse(_baseURL);
    final headers = {'X-Api-Key': '${dotenv.env['API_NINJAS_KEY']}'};

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        joke = result[0]['joke'];
      } else {
        print(response);
        throw Exception('Failed to load Quote...');
      }
    } catch (e) {
      joke = ';(';
    } finally {
      notifyListeners();
    }
  }
}
