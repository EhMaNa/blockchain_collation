import 'package:collation_app/custom/route_generator.dart';
import 'package:collation_app/models/candidate_stateManager.dart';
import 'package:flutter/material.dart';
import 'package:collation_app/candidate_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
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
      onGenerateRoute: (routeSettings) => generateRoute(routeSettings),
    );
  }
}
