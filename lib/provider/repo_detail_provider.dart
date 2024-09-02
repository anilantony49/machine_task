import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/dbHelper/database_helper.dart';

// The provider class that handles the state of the repository details screen.
class RepoDetailProvider with ChangeNotifier {
  bool _isSaved =
      false; // Private variable to track if the repository is saved.
  final Repository repo; // The repository object that this provider works with.

  // Getter to check if the repository is saved.
  bool get isSaved => _isSaved;

  // Constructor that initializes the provider with a repository.
  // It also checks if the repository is saved in the local database.
  RepoDetailProvider({required this.repo}) {
    _checkIfSaved();
  }
// Private function to check if the repository is saved in the local database.
  // It queries the database to see if the repository exists.
  Future<void> _checkIfSaved() async {
    final dbHelper =
        DatabaseHelper.instance; // Singleton instance of the database helper.
    final db = await dbHelper.database; // Access the database.
    // Query the database to see if the repository with the given id exists.
    final List<Map<String, dynamic>> maps = await db.query(
      'repositories',
      where: 'id = ?',
      whereArgs: [repo.id],
    );

    _isSaved =
        maps.isNotEmpty; // Set _isSaved to true if the repository exists.
    notifyListeners(); // Notify listeners to update the UI.
  }

  // Function to toggle the saved state of the repository.
  // If the repository is already saved, it removes it from the database.
  // Otherwise, it saves the repository to the database.
  Future<void> toggleSaveRepo() async {
    final dbHelper =
        DatabaseHelper.instance; // Singleton instance of the database helper.
    if (_isSaved) {
      await dbHelper.deleteRepository(
          repo.id); // Delete the repository from the database.
      _isSaved = false; // Update the saved state.
      _showSnackBar(
          'Repository removed!'); // Show a message indicating the repository was removed.
    } else {
      await dbHelper
          .insertRepository(repo); // Insert the repository into the database.
      _isSaved = true; // Update the saved state.
      _showSnackBar(
          'Repository saved!'); // Show a message indicating the repository was saved.
    }
    notifyListeners(); // Notify listeners to update the UI.
  }

// Function to show a SnackBar with a message.
  // This is currently a placeholder and needs implementation.
  void _showSnackBar(String message) {
    // This function will handle showing SnackBar messages.
  }
}
