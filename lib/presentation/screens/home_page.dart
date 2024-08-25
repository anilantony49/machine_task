import 'package:flutter/material.dart';
import 'package:machine_task/presentation/screens/list_last_60_screen.dart';
import 'package:machine_task/presentation/screens/saved_repo_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE36731),
        title: const Text('Home Page',
            // style: GoogleFonts.aBeeZee(),
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
        actions: [
          // IconButton(onPressed: , icon: icon)
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SavedReposScreen(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  'Saved Repos',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(15.0), // Adjust the radius as needed
                color: const Color.fromARGB(255, 243, 148, 107),
              ),
              child: ListTile(
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
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      15.0), // Adjust the radius as needed
                  color: const Color.fromARGB(255, 243, 148, 107),
                ),
                child: ListTile(
                  title: const Text(
                      'Click here to see the most starred GitHub repos that were created in the last 30 days.'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListAllRepoScreen()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
