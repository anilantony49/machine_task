import 'package:flutter/material.dart';
import 'package:machine_task/provider/repo_provider_for_last_60_days.dart';
import 'package:machine_task/widgets/repo_list_tile.dart';
import 'package:machine_task/provider/repo_provider_for_last_30_days.dart';

class CustomRepoListScrollbar extends StatelessWidget {
  final RepoProviderForLast30Days? repoProviderForLast30Days;
  final RepoProviderForLast60Days? repoProviderForLast60Days;

  const CustomRepoListScrollbar(
      {this.repoProviderForLast30Days,
      super.key,
      this.repoProviderForLast60Days});

  /// Builds the list of repositories.
  /// Displays a loading indicator if the repositories are still being fetched.
  @override
  Widget build(BuildContext context) {
    // Choose the correct provider based on which one is passed
    final repos =
        repoProviderForLast30Days?.repos ?? repoProviderForLast60Days?.repos;
    final scrollController = repoProviderForLast30Days?.scrollController ??
        repoProviderForLast60Days?.scrollController;
    final isLoadingMore = repoProviderForLast30Days?.isLoadingMore ??
        repoProviderForLast60Days?.isLoadingMore;
    if (repos == null || repos.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return RawScrollbar(
      thumbColor: Colors.white, // Color of the scrollbar thumb
      minThumbLength: 100,
      controller: scrollController, // Scroll controller for the list
      thumbVisibility: true, // Make the scrollbar thumb always visible
      thickness: 10.0, // Thickness of the scrollbar thumb
      radius:
          const Radius.circular(5), // Radius for the scrollbar thumb corners
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          controller: scrollController, // Attach the scroll controller
          itemCount: (isLoadingMore == true)
              ? repos.length + 1
              : repos.length, // Otherwise, just show the list of repositories
          itemBuilder: (context, index) {
            // Check if the current index is within the bounds of the repository list
            if (index < repos.length) {
              final repo = repos[index];
              return RepoListTile(
                  repo: repo); // Display a list tile for the repository
            } else {
              // If it's the last item and more data is being loaded, show a loading indicator
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          separatorBuilder: (context, index) =>
              const Divider(), // Add a divider between list items
        ),
      ),
    );
  }
}
