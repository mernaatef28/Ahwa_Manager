import 'package:flutter/material.dart';

import 'core/app_deps.dart';
import 'home_shell.dart';


void main() {
  final deps = AppDeps();
  runApp(DepsScope(deps: deps, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'Smart Ahwa',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.brown),
      home: const HomeShell(),
    );
  }
}
