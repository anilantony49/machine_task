import 'package:flutter/material.dart';
import 'package:machine_task/provider/saved_repo_provider.dart';
import 'package:provider/provider.dart';

class SavedReposScreen extends StatelessWidget {
  const SavedReposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SavedReposProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Saved Repositories'),
          backgroundColor: const Color(0xFFE36731),
        ),
        body: Consumer<SavedReposProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.errorMessage != null) {
              return Center(child: Text('Error: ${provider.errorMessage}'));
            } else if (provider.savedRepos.isEmpty) {
              return const Center(
                child: Text('No items saved'),
              );
            } else {
              final repos = provider.savedRepos;

              return ListView.builder(
                  itemCount: repos.length,
                  itemBuilder: (context, index) {
                    final repo = repos[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: const LinearGradient(
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
                              onPressed: () => provider.removeRepo(repo.id),
                              child: const Text(
                                'Remove',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                          onTap: () {
                            // Handle repo tap, e.g., navigate to repo details
                          },
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
