import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/dbHelper/database_helper.dart';

class SavedReposProvider with ChangeNotifier {
  List<Repository> _savedRepos = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<Repository> get savedRepos => _savedRepos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  SavedReposProvider() {
    _fetchSavedRepos();
  }

  Future<void> _fetchSavedRepos() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      final dbHelper = DatabaseHelper.instance;
      final db = await dbHelper.database;
      final List<Map<String, dynamic>> maps = await db.query('repositories');

      _savedRepos = List.generate(maps.length, (i) {
        return Repository(
          id: maps[i]['id'],
          repoName: maps[i]['repoName'],
          userName: maps[i]['userName'],
          imageUrl: maps[i]['imageUrl'],
          stargazersCount: maps[i]['stargazersCount'],
          description: maps[i]['description'],
        );
      });
    } catch (e) {
      _errorMessage = 'Failed to load saved repositories';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeRepo(String id) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.deleteRepository(id);
    _fetchSavedRepos(); // Refresh the list after deletion
  }
}
