import 'package:flutter/material.dart';
import 'package:rock_leaf_scissor/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Leaf Scissor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 7, 54, 240),
        ),
      ),
      home: const HomePage(),
    );
  }
}
