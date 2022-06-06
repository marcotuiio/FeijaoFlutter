// ignore_for_file: avoid_print, avoid_unnecessary_containers
import 'dart:convert';
import 'package:feijao_magico_uel/network/game_net.dart';
import 'package:feijao_magico_uel/network/games_model.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart';

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

  Future<GamesModel> updateApiPlease(
      int stars, int strength, String gameCode) async {
    final String url =
        "https://marcotuiio.github.io/Data/" + gameCode + ".json";

    Map<String, dynamic> body = {
      "stars": stars,
      "strength": strength,
    };

    Response response = await post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      print(response.body);
      final String responseString = response.body;
      return GamesModel.fromJson(json.decode(responseString));
    } else {
      throw Exception("ERRO AO OBTER URL");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
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
                    return Column(
                      children: <Widget>[
                        Text(
                          "${snapshot.data!.jogos![0].nomeFantasia}",
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "${snapshot.data!.jogos![0].disciplina}",
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "${snapshot.data!.jogos![0].qtdEstrelinhas} estrelinhas",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${snapshot.data!.jogos![0].forca} força",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
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
          FloatingActionButton.extended(
            onPressed: () {
              updateApiPlease(99, 99, _gameCode);
              print(gameObjects.toString());
            },
            label: const Text('NOVO'),
            backgroundColor: Colors.green[700],
          ),
        ],
      ),
    );
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
            });
          },
        ),
      ),
    );
  }
}
