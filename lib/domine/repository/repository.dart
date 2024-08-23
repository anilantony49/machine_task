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

  Future<List<Repository>> getMostStarredRepos() async {
    // Calculate the date for 30 days ago
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    final formattedDate = thirtyDaysAgo.toIso8601String().split('T').first;

    // Construct the full URL
    final String url =
        '$_baseUrl$_searchPath?q=created:>$formattedDate&sort=stars&order=desc';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> jsonData = json.decode(response.body);
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
