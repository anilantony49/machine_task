import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/domine/repository/repository.dart';
import 'package:machine_task/provider/repo_provider.dart';
import 'package:provider/provider.dart';

class ListForLastThirtyDays extends StatefulWidget {
  const ListForLastThirtyDays({super.key});

  @override
  State<ListForLastThirtyDays> createState() => _ListForLastThirtyDaysState();
}

class _ListForLastThirtyDaysState extends State<ListForLastThirtyDays> {
  // final scrollController = ScrollController();
  // bool isLoadingMore = false;
  // List<Repository> repos = [];
  // int page = 1;

  // @override
  // void initState() {
  //   super.initState();
  //   scrollController.addListener(_scrollListener);
  //   fetchRepos();
  // }

  // Future<void> fetchRepos() async {
  //   try {
  //     final newRepos =
  //         await GitHubRepository.getMostStarredReposforlast30Days(page);
  //     setState(() {
  //       repos.addAll(newRepos);
  //     });
  //   } catch (e) {
  //     // Handle error
  //     print('Error: $e');
  //   }
  // }

  // Future<void> _scrollListener() async {
  //   if (isLoadingMore) return;
  //   if (scrollController.position.pixels ==
  //       scrollController.position.maxScrollExtent) {
  //     setState(() {
  //       isLoadingMore = true;
  //     });
  //     page = page + 1;
  //     await fetchRepos();
  //     setState(() {
  //       isLoadingMore = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final repoProvider = Provider.of<RepoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('List For Last 30 Days'),
      ),
      body: repoProvider.repos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RawScrollbar(
              thumbColor: Colors.white,
              // trackColor: Colors.white,
              // thumbColor: Colors.white,
              minThumbLength: 100,
              controller: repoProvider.scrollController,
              thumbVisibility: true,
              thickness: 10.0,
              radius: const Radius.circular(5),
              child: ListView.separated(
                controller: repoProvider.scrollController,
                itemCount: repoProvider.isLoadingMore
                    ? repoProvider.repos.length + 1
                    : repoProvider.repos.length,
                itemBuilder: (context, index) {
                  print(repoProvider.repos.length);
                  if (index < repoProvider.repos.length) {
                    final repo = repoProvider.repos[index];
                    return ListTile(
                      leading: CircleAvatar(
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
                                    fontSize: 14, fontWeight: FontWeight.w700),
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
    );
  }
}
