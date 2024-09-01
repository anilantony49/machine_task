import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machine_task/data/model.dart';

class GitHubRepository {
  static const String _baseUrl = 'https://api.github.com';
  static const String _searchPath = '/search/repositories';

  // Generic method to fetch the most starred repositories for a given number of days
  static Future<List<Repository>> _getMostStarredRepos(
      int days, int page) async {
    // Get the current date and subtract the specified number of days

    final DateTime now = DateTime.now();
    final String formattedDate = now
        .subtract(Duration(days: days))
        .toIso8601String()
        .split('T')
        .first; // Format the date as 'YYYY-MM-DD'

    // Construct the URL for the API request

    final String url =
        "$_baseUrl$_searchPath?q=created:>$formattedDate&sort=stars&order=desc&page=$page";

    try {
      // Perform the HTTP GET request
      final response = await http.get(Uri.parse(url));
      // Handle the response based on the status code

      switch (response.statusCode) {
        case 200:
          // If the request is successful, parse the response body

          final Map<String, dynamic> jsonData = jsonDecode(response.body);
          final List<dynamic> items = jsonData['items'];
          // Convert the list of JSON objects to a list of Repository objects

          return items.map((json) => Repository.fromJson(json)).toList();

        case 400:
          // Handle a bad request error (HTTP 400)

          throw Exception(
              'Bad request: The server could not understand the request.');

        case 401:
          // Handle an unauthorized error (HTTP 401)

          throw Exception(
              'Unauthorized: Access is denied due to invalid credentials.');

        case 403:
          // Handle a forbidden error (HTTP 403)

          throw Exception(
              'Forbidden: You do not have permission to access the resource.');

        case 404:
          // Handle a not found error (HTTP 404)

          throw Exception(
              'Not Found: The requested resource could not be found.');

        case 500:
          // Handle an internal server error (HTTP 500)

          throw Exception(
              'Internal Server Error: The server encountered an error.');

        case 503:
          // Handle a service unavailable error (HTTP 503)

          throw Exception(
              'Service Unavailable: The server is currently unavailable.');

        default:
          // Handle any other unexpected status codes

          throw Exception(
              'Failed to load repositories: ${response.statusCode}');
      }
    } catch (e) {
      // Catch and handle any errors that occur during the request

      throw Exception('Failed to fetch data: $e');
    }
  }

  // Method to get the most starred repositories for the last 60 days
  static Future<List<Repository>> getMostStarredReposForLast60Days(
      int page) async {
    return _getMostStarredRepos(60, page);
  }

  // Method to get the most starred repositories for the last 30 days
  static Future<List<Repository>> getMostStarredReposForLast30Days(
      int page) async {
    return _getMostStarredRepos(30, page);
  }
}
