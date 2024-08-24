import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/database_helper.dart';

class SavedReposScreen extends StatefulWidget {
  const SavedReposScreen({super.key});

  @override
  _SavedReposScreenState createState() => _SavedReposScreenState();
}

class _SavedReposScreenState extends State<SavedReposScreen> {
  late Future<List<Repository>> _savedRepos;

  @override
  void initState() {
    super.initState();
    _savedRepos = _fetchSavedRepos();
  }

  Future<List<Repository>> _fetchSavedRepos() async {
    final dbHelper = DatabaseHelper.instance;
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('repositories');

    return List.generate(maps.length, (i) {
      return Repository(
        id: maps[i]['id'],
        repoName: maps[i]['repoName'],
        userName: maps[i]['userName'],
        imageUrl: maps[i]['imageUrl'],
        stargazersCount: maps[i]['stargazersCount'],
        description: maps[i]['description'],
      );
    });
  }

  Future<void> _removeRepo(String id) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper. deleteRepository(id);
    setState(() {
      _savedRepos = _fetchSavedRepos(); // Refresh the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Repositories'),
        backgroundColor: const Color(0xFFE36731),
      ),
      body: FutureBuilder<List<Repository>>(
        future: _savedRepos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No saved repositories.'));
          } else {
            final repos = snapshot.data!;
            return ListView.builder(
              itemCount: repos.length,
              itemBuilder: (context, index) {
                final repo = repos[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFE36731),
                          Color(0xFFDABE5D)
                        ], // Custom gradient
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: repo.imageUrl != null
                            ? NetworkImage(repo.imageUrl!)
                            : null,
                        child: repo.imageUrl == null
                            ? const Icon(Icons.code)
                            : null,
                      ),
                      title: Text(repo.repoName),
                      subtitle: Text('${repo.stargazersCount} stars'),
                      trailing: TextButton(
                          onPressed: () => _removeRepo(repo.id),
                          child: const Text(
                            'Remove',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                      onTap: () {
                        // Handle repo tap, e.g., navigate to repo details
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
