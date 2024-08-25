import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/dbHelper/database_helper.dart';

class RepoDetailProvider with ChangeNotifier {
  bool _isSaved = false;
  final Repository repo;

  bool get isSaved => _isSaved;

  RepoDetailProvider({required this.repo}) {
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    final dbHelper = DatabaseHelper.instance;
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'repositories',
      where: 'id = ?',
      whereArgs: [repo.id],
    );

    _isSaved = maps.isNotEmpty;
    notifyListeners();
  }

  Future<void> toggleSaveRepo() async {
    final dbHelper = DatabaseHelper.instance;
    if (_isSaved) {
      await dbHelper.deleteRepository(repo.id);
      _isSaved = false;
      _showSnackBar('Repository removed!');
    } else {
      await dbHelper.insertRepository(repo);
      _isSaved = true;
      _showSnackBar('Repository saved!');
    }
    notifyListeners();
  }

  void _showSnackBar(String message) {
    // This function will handle showing SnackBar messages.
  }
}
