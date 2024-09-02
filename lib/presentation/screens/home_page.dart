import 'package:flutter/material.dart';
import 'package:machine_task/constant/constants.dart';
import 'package:machine_task/presentation/screens/list_last_30_screen.dart';
import 'package:machine_task/presentation/screens/list_last_60_screen.dart';
import 'package:machine_task/presentation/screens/saved_repo_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Container to hold the ListTile for 60-day starred GitHub repos
            _buildRepoTile(
              context,
              title: AppStrings.last60DaysReposTitle,
              screen: const ListAllLast60StaredRepoScreen(),
            ),
            const SizedBox(
              height: 20,
            ),
            // Container to hold the ListTile for 30-day starred GitHub repos
            _buildRepoTile(
              context,
              title: AppStrings.last30DaysReposTitle,
              screen: const ListAllLast30StaredRepoScreen(),
            ),
          ],
        ),
      ),
    );
  }

// Appbar for home page
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFE36731),
      title: const Text(
        'Home Page',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => _navigateToScreen(context, const SavedReposScreen()),
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              'Saved Repos',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildRepoTile(BuildContext context,
      {required String title, required Widget screen}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color.fromARGB(255, 243, 148, 107),
      ),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () => _navigateToScreen(context, screen),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
