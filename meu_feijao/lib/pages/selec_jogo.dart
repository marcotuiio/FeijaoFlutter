// ignore_for_file: avoid_unnecessary_containers, avoid_print, sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';
import 'package:feijao_magico_uel/network/game_net.dart';
import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:feijao_magico_uel/pages/body.dart';
import 'package:feijao_magico_uel/pages/game_code.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SelecionarJogo extends StatefulWidget {
  const SelecionarJogo({Key? key}) : super(key: key);

  @override
  _SelecionarJogoState createState() => _SelecionarJogoState();
}

class _SelecionarJogoState extends State<SelecionarJogo> {
  List<dynamic> _items = [];
  Map<String, dynamic> myGame = {};
  late Jogos finalGame;
  late Future<GamesModel> gameObjects;
  final String _gameCode = "gamesdata";

  @override
  void initState() {
    super.initState();
    gameObjects = NetworkGame().getGamesModel(gameCode: _gameCode);
    gameObjects.then((value) {
      // print(value.jogos![2].nomeFantasia);
    });
  }

  Future<String> getFilePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/gamesdata.json";
    print(filePath);

    return filePath;
  }

  void readFile() async {
    File file = File(await getFilePath());
    String contents = await file.readAsString();
    final data = json.decode(contents);
    var teste = GamesModel.fromJson(data);
    setState(() {
      _items = teste.jogos!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            const Text(
              'Olá, [nome].',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
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
            const SizedBox(height: 15),
            const Text(
              '-- Escolha seu jogo --',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              child: const Text('Exibir Jogos'),
              onPressed: readFile,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
            ),
            // const SizedBox(height: 5),
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Column(children: <Widget>[
                          const SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    // print(json.encode(_items[index]));
                                    myGame =
                                        json.decode(json.encode(_items[index]));
                                    finalGame = Jogos.fromJson(myGame);
                                    // print(finalGame.nomeFantasia);
                                  });
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                        atual: finalGame,
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.gamepad),
                                label: Text(_items[index].nomeFantasia),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.lightGreen,
                                  onPrimary: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ]);
                      },
                    ),
                  )
                : Container(),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton.extended(
                  heroTag: 'btn1',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => CodigoJogo()),
                      ),
                    );
                  },
                  label: const Text('NOVO'),
                  backgroundColor: Colors.green[700],
                ),
                const SizedBox(width: 15),
                // FloatingActionButton.extended(
                //   heroTag: 'btn2',
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: ((context) => const HomeScreen()),
                //       ),
                //     );
                //   },
                //   label: const Text('SAIR'),
                //   backgroundColor: Colors.red,
                // ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

//            Container(
//               child: FutureBuilder<GamesModel>(
//                 future: gameObjects,
//                 builder:
//                     (BuildContext context, AsyncSnapshot<GamesModel> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.data != null) {
//                       // ok
//                       return cardSelectGame(snapshot, context);
//                     } else {
//                       // erro de nao ter carregado dados
//                       return Text("error: ${snapshot.error}");
//                     }
//                     // erro de conexão com o server
//                   } else if (snapshot.connectionState == ConnectionState.none) {
//                     return Text("error: ${snapshot.error}");
//                   } else {
//                     // conectou mas não carregou ainda
//                     return const Padding(
//                       padding: EdgeInsets.all(15),
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),
//             ),