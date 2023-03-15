import 'package:collation_app/screens/add_candidate.dart';
import 'package:collation_app/screens/authorize.dart';
import 'package:collation_app/show_collation.dart';
import "package:flutter/material.dart";

MaterialPageRoute generateRoute(RouteSettings routeSettings) {
  final arguments = routeSettings.arguments;
  switch (routeSettings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const Authorize());
    case '/addCandidate':
      return MaterialPageRoute(builder: (_) => const AddCandidate());
    case '/showPresidentialSimple':
      return MaterialPageRoute(
          builder: (_) => Show(category: arguments as String));
    default:
      return MaterialPageRoute(builder: (_) => const Authorize());
  }
}
