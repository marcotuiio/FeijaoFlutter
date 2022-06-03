// ignore_for_file: avoid_print, avoid_unnecessary_containers

import 'package:feijao_magico_uel/network/game_net.dart';
import 'package:feijao_magico_uel/network/games_model.dart';
import "package:flutter/material.dart";


class GameTest extends StatefulWidget {
  const GameTest({Key? key}) : super(key: key);

  @override
  State<GameTest> createState() => _GameTestState();
}

class _GameTestState extends State<GameTest> {
  late Future<GamesModel> gameObjects;
  String _gameCode = "As12qw";

  @override
  void initState() {
    super.initState();
    gameObjects = NetworkGame().getGamesModel(gameCode: _gameCode);
    gameObjects.then((value) {
      print(value.jogos![0].nomeFantasia);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        textFiledView(),
        Container(
          child: FutureBuilder<GamesModel>(
            future: gameObjects,
            builder:
                (BuildContext context, AsyncSnapshot<GamesModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  // ok
                  return Text(
                    "${snapshot.data!.jogos![0].nomeFantasia}",
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  );
                } else {
                  // erro de nao ter carregado dados
                  return Text("error: ${snapshot.error}");
                }
                // erro de conexão com o server
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text("error: ${snapshot.error}");
              } else {
                // conectou mas não carregou ainda
                return const Padding(
                  padding: EdgeInsets.all(15),
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    ));
  }

  Widget textFiledView() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
            hintText: "Choose a CODE",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.all(8),
          ),
          onSubmitted: (value) {
            setState(() {
              _gameCode = value;
              gameObjects = NetworkGame().getGamesModel(gameCode: _gameCode);
              int estre = 24;
              int forc = 12;
              gameObjects = NetworkGame().createStarsStrength(estre, forc, _gameCode);
            });
          },
        ),
      ),
    );
  }
}
