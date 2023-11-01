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
  int totalQuestions = 0;

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
  }

  void loadNewQuestion() async {
    if (pokemonNames.isEmpty || totalQuestions % 10 == 0) {
      List<Pokemon> pokemonList = await PokeAPI.getPokemonList();

      setState(() {
        pokemonNames = pokemonList;
        totalQuestions = 0;
        correctAnswers = 0;
      });
    }

    choosePokemon();
  }

  void checkAnswer(int selectedPokemonId) {
    if (selectedPokemonId == pokemonNames[correctPokemon].id) {
      setState(() {
        correctAnswers++;
        totalQuestions++;

        // Exibir uma mensagem de acerto
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Parabéns, você selecionou o pokémon correto !!!"),
            backgroundColor: Colors.green,
          ),
        );


      });
    } else {
      // Exibir uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Você selecionou o pokemon errado !!!"),
          backgroundColor:  Colors.red,
        ),
      );
      totalQuestions++;
    }
            if (totalQuestions % 10 == 0) {
          // Mostrar um diálogo informando sobre o reinício do quiz
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Fim do Quiz"),
                content: Text("Parabéns você acertou $correctAnswers de $totalQuestions perguntas."),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      loadNewQuestion();
                    },
                    child: Text("Reiniciar Quiz"),
                  ),
                ],
              );
            },
          );
        }

    choosePokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            Text("Acertos: $correctAnswers de $totalQuestions"),
            const SizedBox(height: 20),
            // Espaço reservado para a imagem (quadrado vazio)
            Container(
              width: 200, // Largura desejada do espaço reservado
              height: 200, // Altura desejada do espaço reservado
              decoration: BoxDecoration(
                border: Border.all(width: 2),
              ),
              child: Center(
                child: Image.network(pokemonNames[correctPokemon].image),
              ),
            ),
            const SizedBox(height: 20),
            // Botão com o nome do Pokémon correto
          Padding(padding: const EdgeInsets.all(8), child: ElevatedButton(
              onPressed: () => checkAnswer(PokemonsChoose[0].id),
              child: Text(PokemonsChoose[0].name, style: TextStyle(fontSize: 18)), 
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                minimumSize: const Size.fromHeight(50)
              ),
            ),
            ),
            // Botões com os nomes dos Pokémon aleatorizados
             Padding(padding: const EdgeInsets.all(8), child: ElevatedButton(
              onPressed: () => checkAnswer(PokemonsChoose[1].id),
              child: Text(PokemonsChoose[1].name, style: TextStyle(fontSize: 18)), 
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                minimumSize: const Size.fromHeight(50)
              ),
            ),
            ),
             Padding(padding: const EdgeInsets.all(8), child: ElevatedButton(
              onPressed: () => checkAnswer(PokemonsChoose[2].id),
              child: Text(PokemonsChoose[2].name, style: TextStyle(fontSize: 18)), 
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                minimumSize: const Size.fromHeight(50)
              ),
            )
            ),
            Padding(padding: const EdgeInsets.all(8), child: ElevatedButton(
              onPressed: () => checkAnswer(PokemonsChoose[3].id),
              child: Text(PokemonsChoose[3].name, style: TextStyle(fontSize: 18)), 
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                minimumSize: const Size.fromHeight(50)
              ),
            ),)
          ],
        ),
      ),
    );
  }
}
