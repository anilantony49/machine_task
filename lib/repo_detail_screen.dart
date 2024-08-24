import 'package:flutter/material.dart';
import 'package:machine_task/data/model.dart';
import 'package:machine_task/database_helper.dart';

class RepoDetailScreen extends StatefulWidget {
  final Repository repo;

  const RepoDetailScreen({super.key, required this.repo});

  @override
  State<RepoDetailScreen> createState() => _RepoDetailScreenState();
}

class _RepoDetailScreenState extends State<RepoDetailScreen> {
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    final dbHelper = DatabaseHelper.instance;
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'repositories',
      where: 'id = ?',
      whereArgs: [widget.repo.id],
    );

    setState(() {
      _isSaved = maps.isNotEmpty;
    });
  }

  // Future<void> _saveRepo(BuildContext context) async {
  //   try {
  //     final dbHelper = DatabaseHelper.instance;
  //     await dbHelper.insertRepository(widget.repo);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Repository saved!'),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to save repository: $e'),
  //       ),
  //     );
  //   }
  // }

  Future<void> _toggleSaveRepo() async {
    final dbHelper = DatabaseHelper.instance;
    if (_isSaved) {
      await dbHelper.deleteRepository(widget.repo.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Repository removed!'),
        ),
      );
    } else {
      await dbHelper.insertRepository(widget.repo);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Repository saved!'),
        ),
      );
    }

    setState(() {
      _isSaved = !_isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.repo.repoName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed:  _toggleSaveRepo,
              icon: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(
                  _isSaved ? Icons.bookmark : Icons.bookmark_border,
                  size: 25,
                ),
              ))
        ],
        backgroundColor: const Color(0xFFE36731), // Custom color for the AppBar
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE36731), Color(0xFFDABE5D)], // Custom gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.repo.imageUrl != null)
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.repo.imageUrl!),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                widget.repo.repoName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Username: ${widget.repo.userName}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${widget.repo.stargazersCount} stars',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    widget.repo.description ?? 'No description available.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
