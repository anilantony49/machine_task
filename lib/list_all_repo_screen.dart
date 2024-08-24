import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/domine/repository/repository.dart';
import 'package:machine_task/repo_detail_screen.dart';

class ListAllRepoScreen extends StatefulWidget {
  const ListAllRepoScreen({super.key});

  @override
  State<ListAllRepoScreen> createState() => _ListAllRepoScreenState();
}

class _ListAllRepoScreenState extends State<ListAllRepoScreen> {
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  List<Repository> repos = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchRepos();
  }

  Future<void> fetchRepos() async {
    try {
      final newRepos = await GitHubRepository.getMostStarredRepos(page);
      setState(() {
        repos.addAll(newRepos);
      });
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  Future<void> _scrollListener() async {
    if (isLoadingMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      page = page + 1;
      await fetchRepos();
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE36731),
        title: const Text(
          'Most Starred Repos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE36731), Color(0xFFDABE5D)], // Custom gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: repos.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : RawScrollbar(
                minThumbLength: 100,
                controller: scrollController,
                thumbVisibility: true,
                thickness: 10.0,
                radius: const Radius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: isLoadingMore ? repos.length + 1 : repos.length,
                    itemBuilder: (context, index) {
                      print(repos.length);
                      if (index < repos.length) {
                        final repo = repos[index];
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: repo.imageUrl != null
                                ? NetworkImage(repo.imageUrl!)
                                : null,
                            child: repo.imageUrl == null
                                ? const Icon(Icons.code)
                                : null,
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
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    repo.userName,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              if (repo.description != null)
                                SizedBox(
                                  child: Text(
                                    repo.description!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RepoDetailScreen(
                                          repo: repo,
                                        )));
                            // Optionally handle repo tap, e.g., navigate to repo details
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ),
              ),
      ),
    );
  }
}
