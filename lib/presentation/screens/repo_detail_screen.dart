import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/provider/repo_detail_provider.dart';
import 'package:machine_task/widgets/repo_details_widget.dart';
import 'package:provider/provider.dart';

class RepoDetailScreen extends StatelessWidget {
  final Repository repo;

  const RepoDetailScreen({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RepoDetailProvider(repo: repo),
      child: Consumer<RepoDetailProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: buildAppBar(context, repo),
            body: buildBody(repo),
          );
        },
      ),
    );
  }
}
