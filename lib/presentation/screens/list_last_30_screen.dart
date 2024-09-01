import 'package:flutter/material.dart';
import 'package:machine_task/custom_appbar.dart';
import 'package:machine_task/provider/repo_provider_for_last_30_days.dart';
import 'package:machine_task/repo_list_tile.dart';
import 'package:provider/provider.dart';

class ListAllLast30StaredRepoScreen extends StatelessWidget {
  const ListAllLast30StaredRepoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repoProvider = Provider.of<RepoProviderForLast30Days>(context);
    return Scaffold(
        appBar: const CustomAppBar(title: 'List For Last 30 Days'),
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
            child: _buildRepoList(context, repoProvider)));
  }

  Widget _buildRepoList(
      BuildContext context, RepoProviderForLast30Days repoProvider) {
    if (repoProvider.repos.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return RawScrollbar(
      thumbColor: Colors.white,
      minThumbLength: 100,
      controller: repoProvider.scrollController,
      thumbVisibility: true,
      thickness: 10.0,
      radius: const Radius.circular(5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          controller: repoProvider.scrollController,
          itemCount: repoProvider.isLoadingMore
              ? repoProvider.repos.length + 1
              : repoProvider.repos.length,
          itemBuilder: (context, index) {
            if (index < repoProvider.repos.length) {
              final repo = repoProvider.repos[index];
              return RepoListTile(repo: repo); // Use the reusable widget
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
