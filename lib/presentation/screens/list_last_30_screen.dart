import 'package:flutter/material.dart';
import 'package:machine_task/constant/constants.dart';
import 'package:machine_task/widgets/custom_appbar.dart';
import 'package:machine_task/widgets/custom_repoList_scrollbar.dart';
import 'package:machine_task/provider/repo_provider_for_last_30_days.dart';
import 'package:provider/provider.dart';

/// This screen displays a list of the most starred GitHub repositories
/// created in the last 30 days. It uses the `RepoProviderForLast30Days`
/// for fetching and managing the list of repositories.
class ListAllLast30StaredRepoScreen extends StatelessWidget {
  const ListAllLast30StaredRepoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the RepoProviderForLast30Days instance from the provider
    final repoProvider = Provider.of<RepoProviderForLast30Days>(context);
    return Scaffold(
        // Use a custom AppBar with a title
        appBar: const CustomAppBar(title: 'List For Last 30 Days'),
        // Set up the background gradient for the body
        body: Container(
          decoration: kBodyContainerDecoration,
          child: CustomRepoListScrollbar(
            repoProviderForLast30Days: repoProvider,
            repoProviderForLast60Days: null,
          ),
        ));
  }

}
