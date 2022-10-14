import 'package:collation_app/models/temp.dart';
import 'package:collation_app/screens/add_candidate.dart';
import 'package:collation_app/screens/authorize.dart';
import 'package:flutter/material.dart';
import 'package:collation_app/home_screen.dart';
import 'package:collation_app/screens/level.dart';
import 'package:collation_app/candidate_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      /*ChangeNotifierProvider(
      create: (context) => CandidateServices(),
      child: const MyApp(),
    ),*/
      MultiProvider(
    providers: [
      ChangeNotifierProvider<CandidateServices>(
          create: (context) => CandidateServices()),
      ChangeNotifierProvider<Temporary>(create: (context) => Temporary()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collation dApp',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const Level(),
        "/login": (context) => const Authorize(),
        "/home": (context) => const HomeScreen(),
        "/add": (context) => const AddCandidate(),
      },
    );
  }
}
