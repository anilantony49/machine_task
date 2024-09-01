import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_task/provider/repo_provider_for_last_30_days.dart';
import 'package:machine_task/provider/repo_provider_for_last_60_days.dart';
import 'package:machine_task/presentation/screens/home_page.dart';
import 'package:machine_task/provider/saved_repo_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the roots of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => RepoProviderForLast60Days()),
        ChangeNotifierProvider(
            create: (context) => RepoProviderForLast30Days()),
        // ChangeNotifierProvider(create: (context) => RepoDetailProvider(repo: null)),

        ChangeNotifierProvider(create: (context) => SavedReposProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
