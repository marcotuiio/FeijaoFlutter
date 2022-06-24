// ignore_for_file: avoid_print, must_be_immutable

import 'dart:convert';
import 'dart:io';
// import 'package:feijao_magico_uel/Storages/storages.dart';
import 'package:feijao_magico_uel/network/from_server.dart';
import 'package:feijao_magico_uel/network/game_net.dart';
import 'package:feijao_magico_uel/network/games.dart';
import 'package:feijao_magico_uel/network/updates_on_file.dart';
import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:feijao_magico_uel/pages/config_inicio.dart';
import 'package:feijao_magico_uel/pages/game_code.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

class BotoesMainPage extends StatefulWidget {
  final Jogos currentGame;
  final int index;
  const BotoesMainPage(
      {required this.currentGame, required this.index, Key? key})
      : super(key: key);

  // Storage? storage = Storage(fileofInterest: 'games.json');

  @override
  State<BotoesMainPage> createState() => _BotoesMainPageState();
}

class _BotoesMainPageState extends State<BotoesMainPage> {
  UpdateOnFile updates = UpdateOnFile();
  late File gamesjsonFile;
  late int forca;
  late int currentIndex;
  var now = DateTime.now();
  // bool gamesfileExists = false;
  // Map<String, dynamic> gamesfileContent = {"": ""};
  // Map<String, dynamic> targetcontent = {"": ""};

  late Future<GamesModel> gameObjects;
  final String _gameCode = "gamesdata";
///////////////////////////////////////////////////////////////////////////////
// PROVISÓRIO -> SUBSTITUI O ARQUIVO DO SERVIDOR
  @override
  void initState() {
    forca = widget.currentGame.forca as int;
    currentIndex = widget.index;
    super.initState();
    gameObjects = NetworkGame().getGamesModel(gameCode: _gameCode);
    gameObjects.then((value) {
      value.jogos![0].nomeFantasia = "UM TEST MUITO LOUCO";
      value.jogos![0].codigo = "696Ga";
      print(value.jogos![0].nomeFantasia);
      print(gameObjects.toString());
    });
  }
  // widget.storage!.nameJsonFile().then((File namefile) {
  //   setState(() {
  //     gamesjsonFile = namefile;
  //     print('print case of ');
  //     print(gamesjsonFile);
  //   });
  // });
  //   widget.storage!.checkExist().then((bool existfile) {
  //     setState(() => gamesfileExists = existfile);
  //     if (gamesfileExists) {
  //       print('Hello im here');

  //       final games = gamesFromJson(gamesjsonFile.readAsStringSync());
  //       List<Jogo> listag = games.jogos;
  //       // String gamecode =
  //       setState(() {
  //         gamesfileContent = json.decode(gamesjsonFile.readAsStringSync());
  //         forca =
  //             int.parse(listag[0].forca); //COLOCAR GAME CODE!!!! TIRAR [0];
  //       });

  //       print('conteudo gamjson -> nested!');
  //       print(gamesfileContent);
  //     } else {
  //       print('got down');
  //       setState(() => forca = 20);
  //       createGameJson(gamesjsonFile);
  //     }
  //   });
  // });
  // getApplicationDocumentsDirectory().then((Directory directory) {
  //
  //   InternalData.getGameJson().then((games) {
  //     setState(() {
  //       _games = games;
  //       _loading = false;
  //     });
  //   });
  // });

  // Future<void> createGameJson(File gamesjsonFile) async {
  //   //Building Games json file
  //   final String response =
  //       await rootBundle.loadString('assets/gamesdata.json');
  //   Map<String, dynamic> ghostContent = await json.decode(response.toString());
  //   final dir = await getApplicationDocumentsDirectory();
  //   String fileName = 'games.json';
  //   createFile(ghostContent, dir.path, fileName);
  //   Map<String, dynamic> newContent =
  //       await json.decode(gamesjsonFile.readAsStringSync());
  //   var newobject = newContent["jogos"];
  //   final listlength = newobject.length;
  //   String code = 'As12qw'; //  PROVISORIO!!!!!!
  //   //iMPLEMENTAR DPS UM TRY CATCH, CASO A STRING COM O CODIGO NAO EXISTA
  //   for (int i = 0; i < listlength; i++) {
  //     if (newobject[i]["codigo"] == code) {
  //       targetcontent = newobject[i];
  //       // print('target content');
  //       // print(targetcontent);
  //       break;
  //     }
  //     // print(newobject[i].toString());
  //     // print(newobject[i]["codigo"].toString());
  //   }
  //   String codigo = targetcontent["codigo"];
  //   final String questions =
  //       await rootBundle.loadString('assets/questoes_$codigo.json');
  //   Map<String, dynamic> questionsghostContent =
  //       await json.decode(questions.toString());
  //   final direc = await getApplicationDocumentsDirectory();
  //   String questfileName = 'questoes_$codigo.json';
  //   Storage? queststorage = Storage(fileofInterest: questfileName);
  //   createFile(questionsghostContent, direc.path, questfileName);
  //   late File questionsfile;
  //   queststorage.nameJsonFile().then((File questfile) {
  //     setState(() {
  //       questionsfile = questfile;
  //       print('print case of ');
  //       print(questionsfile);
  //       Map<String, dynamic> questmap =
  //           json.decode(questionsfile.readAsStringSync());
  //       print('questoes');
  //       print(questmap.toString());
  //     });
  //   });

  //   setState(() {
  //     // ignore: unused_local_variable
  //     bool gamefileExists = true;
  //     gamesfileContent = newContent;
  //   });
  //   print('conteudo gamjson -> nested!');
  //   print(gamesfileContent);
  // }

//END OF 'PROVISÓRIO'
///////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    late String background;
    if (forca >= 90) {
      //crescimento normal
      background = 'assets/livroplant2.png';
    } else if (forca >= 70 && forca < 90) {
      //crescimento anormal 1
      background = 'assets/anormal1.png';
    } else if (forca >= 50 && forca < 70) {
      //crescimento anormal 2
      background = 'assets/anormal2.png';
    } else if (forca >= 30 && forca < 50) {
      //crescimento anormal 3
      background = 'assets/anormal3.png';
    } else if (forca >= 1 && forca < 30) {
      //muito fraca
      background = 'assets/fraca.png';
    } else if (forca == 0) {
      //morte da planta
      background = 'assets/morte.png';
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(background),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/star.png'),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/strenght.png'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            const Text(
              'TESTES',
              style: TextStyle(fontSize: 22),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => CadastroInicial()),
                      ),
                    );
                  },
                  icon: const Icon(Icons.engineering),
                  label: const Text('Config Inicial'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CodigoJogo()));
                  },
                  icon: const Icon(Icons.code),
                  label: const Text('Game Code'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    updates.setEstrelinhas(0, currentIndex);
                  },
                  icon: const Icon(Icons.engineering),
                  label: const Text('Alterar arquivo'),
                ),
                // ElevatedButton.icon(
                //   style: ElevatedButton.styleFrom(primary: Colors.black),
                //   onPressed: () {
                //     final games =
                //         gamesFromJson(gamesjsonFile.readAsStringSync());
                //     List<Jogo> listag = games.jogos;
                //     String professor = listag[0].professor;
                //     listag[0].professor = 'Xavier';
                //     listag[0].forca = '100';
                //     print('test');
                //     print('professor = $professor');
                //     print(listag[0].professor);
                //     // gamesToJson(Games(jogos: listag));
                //     String jsonUser = jsonEncode(listag);
                //     print(jsonUser);
                //     gamesjsonFile
                //         .writeAsStringSync(json.encode(Games(jogos: listag)));
                //   },
                //   icon: const Icon(Icons.list),
                //   label: const Text('Get Data'),
                // ),
                FutureBuilder<GamesModel>(
                  future: gameObjects,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null) {
                        // ok
                        return ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.purple),
                          onPressed: () {
                            final games =
                                gamesFromJson(gamesjsonFile.readAsStringSync());
                            var listag = games.jogos[0];
                            var jsonUser = json.encode(listag).toString();
                            var novo = snapshot.data!.jogos;
                            var aux = listag as Jogos;
                            print(aux);
                            novo!.add(aux);
                            print(novo);
                            print(jsonUser);
                            print('test');
                          },
                          icon: const Icon(Icons.list),
                          label: const Text('Print Json'),
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
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                  onPressed: () {
                    print("FULL TIME => $now");
                    print("TODAY => ${now.toString().substring(0, 10)}");
                  },
                  icon: const Icon(Icons.watch),
                  label: const Text("Get time"),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const GameTest()),
                      ),
                    );
                  },
                  icon: const Icon(Icons.watch),
                  label: const Text("TESTE SERVER"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// https://backendless.com/docs/flutter/data_updating_json_data.html
// ler para tentar atualizar json