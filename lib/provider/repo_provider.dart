import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/domine/repository/repository.dart';

class RepoProvider with ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  final List<Repository> _repos = [];
  bool _isLoadingMore = false;
  int _page = 1;

  List<Repository> get repos => _repos;
  bool get isLoadingMore => _isLoadingMore;
  ScrollController get scrollController => _scrollController;

  RepoProvider() {
    _scrollController.addListener(_scrollListener);
    fetchRepos();
  }

  Future<void> fetchRepos() async {
    try {
      final newRepos = await GitHubRepository.getMostStarredRepos(_page);
      _repos.addAll(newRepos);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  // Future<void> _scrollListener() async {
  //   if (_isLoadingMore) return;
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) _isLoadingMore = true;
  //   notifyListeners();
  //   _page += 1;
  //   await fetchRepos();
  //   _isLoadingMore = false;
  //   notifyListeners();
  // }

  Future<void> _scrollListener() async {
    if (_isLoadingMore ||
        _scrollController.position.pixels !=
            _scrollController.position.maxScrollExtent) return;

    _isLoadingMore = true;
    notifyListeners();

    _page += 1;
    await fetchRepos();

    _isLoadingMore = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}
