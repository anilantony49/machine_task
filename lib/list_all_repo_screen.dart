import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/domine/repository/repository.dart';
// import 'package:your_project_name/repository.dart'; // Import your GitHubRepository class and Repository model

class ListAllRepoScreen extends StatelessWidget {
  const ListAllRepoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Most Starred Repos'),
      ),
      body: FutureBuilder<List<Repository>>(
        future: GitHubRepository().getMostStarredRepos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No repositories found.'));
          } else {
            final repos = snapshot.data!;
            return ListView.builder(
              itemCount: repos.length,
              itemBuilder: (context, index) {
                final repo = repos[index];
                return ListTile(
                  // title: Text(repo.name),
                  subtitle: Text('${repo.stargazersCount} stars'),
                  onTap: () {
                    // Optionally handle repo tap, e.g., navigate to repo details
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
