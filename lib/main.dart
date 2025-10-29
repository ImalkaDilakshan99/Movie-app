import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/pages/main_page.dart';
import 'package:movie_app/pages/spalsh_page.dart';

void main() {
  runApp(
    SpalshPage(
      key: UniqueKey(),
      onInitializationComplete: () => runApp(ProviderScope(child: MyApp())),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie_APP',
      initialRoute: 'home',
      routes: {'home': (BuildContext _context) => MainPage()},
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
