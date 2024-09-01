import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/domine/repository/repository.dart';

class RepoProviderForLast60Days with ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  final List<Repository> _repos = [];
  bool _isLoadingMore = false;
  int _page = 1;

  List<Repository> get repos => _repos;
  bool get isLoadingMore => _isLoadingMore;
  ScrollController get scrollController => _scrollController;

  RepoProviderForLast60Days() {
    _scrollController.addListener(_scrollListener);
    fetchReposForLast60Days();
  }

  Future<void> fetchReposForLast60Days() async {
    try {
      if (_page == 1) {
        _repos.clear();
      }
      final newRepos =
          await GitHubRepository.getMostStarredReposForLast60Days(_page);
      _repos.addAll(newRepos);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }


  Future<void> _scrollListener() async {
    if (_isLoadingMore ||
        _scrollController.position.pixels !=
            _scrollController.position.maxScrollExtent) return;

    _isLoadingMore = true;
    notifyListeners();

    _page += 1;
    await fetchReposForLast60Days();

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
