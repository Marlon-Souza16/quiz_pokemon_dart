import 'package:flutter/material.dart';
import 'package:flutter_application_1/pokemon_quiz.dart';

void main() {
  runApp(const PokemonQuizApp());
}

class PokemonQuizApp extends StatelessWidget {
  const PokemonQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PokemonQuizScreen(),
    );
  }
}
