import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/dbHelper/database_helper.dart';
import 'package:machine_task/provider/repo_detail_provider.dart';
import 'package:provider/provider.dart';

class RepoDetailScreen extends StatelessWidget {
  final Repository repo;

  const RepoDetailScreen({super.key, required this.repo});

  // bool _isSaved = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RepoDetailProvider(repo: repo),
      child: Consumer<RepoDetailProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                repo.repoName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: provider.toggleSaveRepo,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(
                        provider.isSaved
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        size: 25,
                      ),
                    ))
              ],
              backgroundColor:
                  const Color(0xFFE36731), // Custom color for the AppBar
            ),
            body: Container(
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (repo.imageUrl != null)
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(repo.imageUrl!),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      repo.repoName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Username: ${repo.userName}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${repo.stargazersCount} stars',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          repo.description ?? 'No description available.',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
