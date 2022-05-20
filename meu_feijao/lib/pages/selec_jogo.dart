import 'package:feijao_magico_uel/network/game_net.dart';
import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:feijao_magico_uel/pages/body.dart';
import 'package:feijao_magico_uel/pages/game_code.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
//import 'dart:io';

class SelecionarJogo extends StatefulWidget {
  const SelecionarJogo({Key? key}) : super(key: key);

  @override
  _SelecionarJogoState createState() => _SelecionarJogoState();
}

class _SelecionarJogoState extends State<SelecionarJogo> {
  List _items = [];
  late Future<GamesModel> gamesObjects;

  @override
  void initState() {
    super.initState();
    gamesObjects = NetworkGame().getGamesModel(gameCode: '4rASx');
    gamesObjects.then((value) {
      //print(value.city!.coord!.lon);
    });
  }

  // Buscando conteudo do arquivo json
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/games.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["jogos"];
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
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              width: 350,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/livroplant.png'),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              '-- Escolha seu jogo --',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Exibir Jogos'),
              onPressed: readJson,
            ),
            const SizedBox(height: 5),
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
                                  // Navigator.pushNamed(context, '/home');
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.gamepad),
                                label: Text(_items[index]["nome_fantasia"]),
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
                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const HomeScreen()),
                      ),
                    );
                  },
                  label: const Text('SAIR'),
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/*
    Container(
      child: FutureBuilder<GamesModel>(
        future: gamesObjects,
        builder:
            (BuildContext context, AsyncSnapshot<WeatherModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              // ok
              return Column(
                children: <Widget>[
                  midView(snapshot),
                  bottomView(context, snapshot),
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
*/

// Widget showGames(AsyncSnapshot<GamesModel> snapshot, BuildContext context) {
//                   Column showGames = Column(
//                     children: <Widget>[
//                           const SizedBox(height: 7),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               const SizedBox(width: 10),
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   // Navigator.pushNamed(context, '/home');
//                                   Navigator.pop(context);
//                                 },
//                                 icon: const Icon(Icons.gamepad),
//                                 label: Text(snapshot.data.nomeFantasia),
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Colors.lightGreen,
//                                   onPrimary: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       );
//                     return showGames;                
// }