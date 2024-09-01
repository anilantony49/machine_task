import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/presentation/screens/repo_detail_screen.dart';

class RepoListTile extends StatelessWidget {
  final Repository repo;

  const RepoListTile({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage:
            repo.imageUrl != null ? NetworkImage(repo.imageUrl!) : null,
        child: repo.imageUrl == null ? const Icon(Icons.code) : null,
      ),
      title: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              repo.repoName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          Text(
            '${repo.stargazersCount} stars',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            repo.userName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          if (repo.description != null)
            Text(
              repo.description!,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RepoDetailScreen(repo: repo),
          ),
        );
      },
    );
  }
}
