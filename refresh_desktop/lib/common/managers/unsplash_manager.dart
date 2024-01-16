import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../models/photo_model.dart';

class UnsplashQuery {
  late String query;
  late int page;
  late int perPage;

  UnsplashQuery(
      {required this.query, required this.page, required this.perPage});
}

class UnsplashManager {
  final String _unsplashEndpoint = "api.unsplash.com";

  Future<UnsplashResponse?> queryImages({required UnsplashQuery query}) async {
    String unsplashAccessKey = dotenv.env['UNSPLASH_API_ACCESS_KEY'] ?? "";
    try {
      Map<String, dynamic> parameters = {
        'query': query.query,
        'per_page': query.perPage.toString(),
        'page': query.page.toString(),
        'client_id': unsplashAccessKey
      };

      const String requestUrl = '/search/photos';
      debugPrint('request url $requestUrl');
      debugPrint('request header: $parameters');
      final response = await http.get(
        Uri.https(_unsplashEndpoint, requestUrl, parameters),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final unsplashResponse = UnsplashResponse.fromJson(data);
        return unsplashResponse;
      } else {
        // Handle HTTP error
        debugPrint('HTTP Error: ${response.statusCode}');
        // You can also access the response body for more information
        debugPrint('Response body: ${response.body}');
        return Future.value(null);
      }
    } catch (error) {
      // Handle other errors, such as network errors
      debugPrint('Error: $error');
      return Future.error(error);
    }
  }
}
