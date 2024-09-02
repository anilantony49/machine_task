import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/provider/repo_detail_provider.dart';
import 'package:provider/provider.dart';

AppBar buildAppBar(BuildContext context, Repository repo) {
  return AppBar(
    title: Text(
      repo.repoName,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [buildSaveButton(context)],
    backgroundColor: const Color(0xFFE36731), // Custom color for the AppBar
  );
}

IconButton buildSaveButton(BuildContext context) {
  return IconButton(
    onPressed: Provider.of<RepoDetailProvider>(context, listen: false)
        .toggleSaveRepo,
    icon: Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Consumer<RepoDetailProvider>(
        builder: (context, provider, child) {
          return Icon(
            provider.isSaved ? Icons.bookmark : Icons.bookmark_border,
            size: 25,
          );
        },
      ),
    ),
  );
}

Widget buildBody(Repository repo) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE36731), Color(0xFFDABE5D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRepoImage(repo),
          const SizedBox(height: 16),
          _buildRepoName(repo),
          const SizedBox(height: 8),
          _buildUserName(repo),
          const SizedBox(height: 8),
          _buildStarCount(repo),
          const SizedBox(height: 16),
          _buildDescriptionTitle(),
          const SizedBox(height: 8),
          _buildDescription(repo),
        ],
      ),
    ),
  );
}

Widget _buildRepoImage(Repository repo) {
  if (repo.imageUrl == null) return const SizedBox.shrink();
  return Center(
    child: CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(repo.imageUrl!),
    ),
  );
}

Widget _buildRepoName(Repository repo) {
  return Text(
    repo.repoName,
    style: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

Widget _buildUserName(Repository repo) {
  return Text(
    'Username: ${repo.userName}',
    style: const TextStyle(
      fontSize: 18,
      color: Colors.white70,
    ),
  );
}

Widget _buildStarCount(Repository repo) {
  return Text(
    '${repo.stargazersCount} stars',
    style: const TextStyle(
      fontSize: 18,
      color: Colors.white70,
    ),
  );
}

Widget _buildDescriptionTitle() {
  return const Text(
    'Description',
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

Widget _buildDescription(Repository repo) {
  return Expanded(
    child: SingleChildScrollView(
      child: Text(
        repo.description ?? 'No description available.',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
      ),
    ),
  );
}
