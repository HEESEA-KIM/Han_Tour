import 'package:flutter/material.dart';
import 'nav_rail.dart';

class NavigationRailApp extends StatelessWidget {
  const NavigationRailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavRail(),
    );
  }
}
