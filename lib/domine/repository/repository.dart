// import 'package:machine_task/api_end_points.dart';

// class Githubrepos{
//    String signUpUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.staredRepo}";
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machine_task/data/model.dart';

class GitHubRepository {
  static const String _baseUrl = 'https://api.github.com';
  static const String _searchPath = '/search/repositories';

  static Future<List<Repository>> getMostStarredRepos(int page) async {
    final DateTime now = DateTime.now();
    final String formattedDate = now
        .subtract(const Duration(days: 60))
        .toIso8601String()
        .split('T')
        .first;

    final String url =
        "$_baseUrl$_searchPath?q=created:>$formattedDate&sort=stars&order=desc&page=$page";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<dynamic> items = jsonData['items'];

        // Convert the list of JSON objects to a list of Repository objects
        return items.map((json) => Repository.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load repositories');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<List<Repository>> getMostStarredReposforlast30Days(
      int page) async {
    final DateTime now = DateTime.now();
    final String formattedDate = now
        .subtract(const Duration(days: 30))
        .toIso8601String()
        .split('T')
        .first;

    final String url =
        "$_baseUrl$_searchPath?q=created:>$formattedDate&sort=stars&order=desc&page=$page";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<dynamic> items = jsonData['items'];

        // Convert the list of JSON objects to a list of Repository objects
        return items.map((json) => Repository.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load repositories');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
