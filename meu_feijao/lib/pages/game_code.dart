// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';
import 'package:feijao_magico_uel/network/game_net.dart';
import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class CodigoJogo extends StatefulWidget {
  const CodigoJogo({Key? key}) : super(key: key);

  @override
  _CodigoJogoState createState() => _CodigoJogoState();
}

class _CodigoJogoState extends State<CodigoJogo> {
  late Future<GamesModel> gameObjects;
  String _code = 'gamesdata';
  var now = DateTime.now();

  late String _name = '';

  late Map<String, dynamic> namefileContent;

  @override
  void initState() {
    super.initState();
    gameObjects = NetworkGame().getGamesModel(gameCode: 'gamesdata');
    readFileTXT();
  }

  void newGame(var fromServer) async {
    Map<String, dynamic> aux = await getFileContents();

    var teste = GamesModel.fromJson(aux);
    var jsonList = teste.jogos!;

    GamesModel snapshot = fromServer;
    var newGame = snapshot.jogos![0];

    jsonList.add(newGame);
    teste.jogos = jsonList;

    final file = File(await getFilePath());
    await file.writeAsString(json.encode(teste));
  }

  Future<Map<String, dynamic>> getFileContents() async {
    File file = File(await getFilePath());
    String contents = await file.readAsString();
    return json.decode(contents);
  }

  Future<String> getFilePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/gamesdata.json";
    return filePath;
  }

  Future<String> getFilePathTXT() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/cadastro.txt";
    return filePath;
  }

  void readFileTXT() async {
    File file = File(await getFilePathTXT());
    String contents = await file.readAsString();
    setState(() {
      _name = contents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Olá, $_name',
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                width: 330,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/livroplant.png'),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Insira o CÓDIGO do novo jogo:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              textFiledViewCode(),
              const SizedBox(height: 20),
              Container(
                child: FutureBuilder<GamesModel>(
                  future: gameObjects,
                  builder: (BuildContext context,
                      AsyncSnapshot<GamesModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null) {
                        // ok
                        return Column(
                          children: <Widget>[
                            ElevatedButton.icon(
                              onPressed: () {
                                newGame(snapshot.data);
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.check),
                              label: const Text('CONFIRMAR'),
                            ),
                          ],
                        );
                      } else {
                        // erro de nao ter carregado dados
                        return Text("error: ${snapshot.error}");
                      }
                      // erro de conexão com o server
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
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
              const SizedBox(height: 5),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      _code,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textFiledViewCode() {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
            hintText: "Código",
            labelText: "CÓDIGO DO JOGO",
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.blue[800],
            ),
            prefixIcon: const Icon(Icons.code),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.all(8),
            fillColor: Colors.black12,
            filled: true,
          ),
          onSubmitted: (value) {
            setState(() {
              _code = value;
              gameObjects = NetworkGame().getGamesModel(gameCode: _code);
            });
          },
          // maxLength: 6,
        ),
      ),
    );
  }
}
