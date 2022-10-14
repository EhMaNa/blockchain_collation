import 'package:collation_app/screens/authorize.dart';
import 'package:flutter/material.dart';
import 'package:collation_app/home_screen.dart';
import 'package:collation_app/screens/level.dart';
import 'package:collation_app/candidate_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CandidateServices(),
      child: const MyApp(),
    ),
  );
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
        "/": (context) => Level(),
        "/login": (context) => Authorize(),
        "/home": (context) => HomeScreen(),
      },
    );
  }
}
