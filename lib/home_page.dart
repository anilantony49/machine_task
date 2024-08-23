import 'package:flutter/material.dart';
import 'package:machine_task/list_all_repo_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Home Page'),
        // actions: [],
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text(
                'Click here to see the most starred Githubrepos that were created in the last 60 days.'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListAllRepoScreen()));
            },
          ),
          Center(
            child: ListTile(
              title: const Text(
                  'Click here to see the most starred GitHub repos that were created in the last 30 days.'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                
              },
            ),
          ),
        ],
      ),
    );
  }
}
