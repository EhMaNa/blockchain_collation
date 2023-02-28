import 'package:collation_app/models/temp.dart';
import 'package:collation_app/screens/add_candidate.dart';
import 'package:collation_app/screens/authorize.dart';
import 'package:collation_app/show_collation.dart';
import 'package:flutter/material.dart';
import 'package:collation_app/candidate_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider<CandidateServices>(
          create: (context) => CandidateServices()),
      ChangeNotifierProvider<CandidateProvider>(
          create: (context) => CandidateProvider()),
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
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: "/login",
      routes: {
        "/login": (context) => const Authorize(),
        "/add": (context) => const AddCandidate(),
        "/show": (context) => const Show(),
      },
    );
  }
}
