import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/pokeapi.dart';
import 'package:flutter_application_1/models/pokemon.dart';

class PokemonQuizScreen extends StatefulWidget {
  const PokemonQuizScreen({super.key});

  @override
  _PokemonQuizScreenState createState() => _PokemonQuizScreenState();
}

class _PokemonQuizScreenState extends State<PokemonQuizScreen> {
  List<Pokemon> pokemonNames = [];
  List<Pokemon> PokemonsChoose = [];
  int correctPokemon = 0;

  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    loadNewQuestion();
  }

  void choosePokemon() {
    setState(() {
      PokemonsChoose = [];

      correctPokemon = Random().nextInt(pokemonNames.length);
      PokemonsChoose.add(pokemonNames[correctPokemon]);
      PokemonsChoose.add(pokemonNames[Random().nextInt(pokemonNames.length)]);
      PokemonsChoose.add(pokemonNames[Random().nextInt(pokemonNames.length)]);
      PokemonsChoose.add(pokemonNames[Random().nextInt(pokemonNames.length)]);

      PokemonsChoose.shuffle();
    });
    print(PokemonsChoose.toString());
  }

  void loadNewQuestion() async {
    if (pokemonNames.isEmpty) {
      List<Pokemon> pokemonList = await PokeAPI.getPokemonList();

      setState(() {
        pokemonNames = pokemonList;
      });
    }

    choosePokemon();
  }

  void checkAnswer(int selectedAnswerIndex) {
    if (correctPokemon != null && selectedAnswerIndex == correctPokemon) {
      setState(() {
        correctAnswers++;
        // Exibir uma mensagem de acerto
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Acerto!"),
          ),
        );
      });
    } else {
      // Exibir uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro."),
        ),
      );
    }

    choosePokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Pokémon"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título
            const Text(
              "QUAL É ESSE POKEMON ?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Texto "Acertos" acima da imagem dos Pokémon
            Text("Acertos: $correctAnswers"),
            const SizedBox(height: 20),
            // Espaço reservado para a imagem (quadrado vazio)
            Container(
              width: 200, // Largura desejada do espaço reservado
              height: 200, // Altura desejada do espaço reservado
              decoration: BoxDecoration(
                border: Border.all(width: 2),
              ),
              child: const Center(
                child: Text("Imagem do Pokémon"),
              ),
            ),
            const SizedBox(height: 20),
            // Botões com os nomes dos Pokémon
            ElevatedButton(
              onPressed: () => checkAnswer(PokemonsChoose[0].id),
              child: Text(PokemonsChoose[0].name),
            ),
            ElevatedButton(
              onPressed: () => checkAnswer(PokemonsChoose[0].id),
              child: Text(PokemonsChoose[0].name),
            ),
            ElevatedButton(
              onPressed: () => checkAnswer(PokemonsChoose[0].id),
              child: Text(PokemonsChoose[0].name),
            ),
            ElevatedButton(
              onPressed: () => checkAnswer(PokemonsChoose[0].id),
              child: Text(PokemonsChoose[0].name),
            )
          ],
        ),
      ),
    );
  }
}
