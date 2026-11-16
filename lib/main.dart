import 'package:flutter/material.dart';
import 'screens/liste_screen.dart';

void main() {
  runApp(const ChattApp());
}

class ChattApp extends StatelessWidget {
  const ChattApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Bleu mer : seule couleur écrite en dur, le reste vient du thème.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B7A9E)),
      ),
      home: const ListeScreen(),
    );
  }
}

