// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';
import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:feijao_magico_uel/network/relatorio_model.dart';
import 'package:feijao_magico_uel/pages/body.dart';
import 'package:feijao_magico_uel/pages/config_inicio.dart';
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

  late String _name = '';

  @override
  void initState() {
    super.initState();
    readFileTXT();
  }

  Future<String> getFilePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/gamesdata.json";
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

  Future<String> getFilePathQuest(String code) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/questions_" + code + ".json";
    return filePath;
  }

  Future<String> getFilePathRelatorio(String code) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/relatorio_" + code + ".json";
    return filePath;
  }

  Future<void> checkJsonEmpty(String code) async {
    File file = File(await getFilePathQuest(code));
    if (!file.existsSync()) {
      // // criando arquivo para relatorio das respostas
      File fileRel = File(await getFilePathRelatorio(code));
      var rel = {"quests": []};
      var rel2 = RelatorioModel.fromJson(rel);
      fileRel.createSync();
      await fileRel.writeAsString(json.encode(rel2));

      setState(() {
        isActiveButtonRega = true;
        isActiveButtonStars = true;
        auxLen = 9;
        isEmpty = 1;
      });
    } else {
      setState(() {
        isEmpty = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            Text(
              'Olá, $_name',
              style: const TextStyle(
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
                                onPressed: () async {
                                  setState(() {
                                    myGame =
                                        json.decode(json.encode(_items[index]));
                                    finalGame = Jogos.fromJson(myGame);
                                  });
                                  await checkJsonEmpty(finalGame.codigo!);
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
                        builder: ((context) => const CodigoJogo()),
                      ),
                    );
                  },
                  label: const Text('NOVO'),
                  backgroundColor: Colors.green[700],
                ),
                const SizedBox(width: 15),
                FloatingActionButton.extended(
                  heroTag: 'btn2',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const CadastroInicial()),
                      ),
                    );
                  },
                  label: const Text('EDITAR NOME'),
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

bool isActiveButtonRega = false;
bool isActiveButtonStars = false;
int auxLen = 0;
int isEmpty = 0;
