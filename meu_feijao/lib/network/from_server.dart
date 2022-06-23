// ignore_for_file: avoid_print, avoid_unnecessary_containers
import 'dart:convert';
import 'dart:io';
import 'package:feijao_magico_uel/network/game_net.dart';
import 'package:feijao_magico_uel/network/games_model.dart';
import "package:flutter/material.dart";
// import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class GameTest extends StatefulWidget {
  const GameTest({Key? key}) : super(key: key);

  @override
  State<GameTest> createState() => _GameTestState();
}

class _GameTestState extends State<GameTest> {
  late Future<GamesModel> gameObjects;
  String _gameCode = "gamesdata";
  var now = DateTime.now();

  @override
  void initState() {
    super.initState();
    gameObjects = NetworkGame().getGamesModel(gameCode: _gameCode);
    gameObjects.then((value) {
      print(value.jogos![0].nomeFantasia);
    });
  }

  // void updateApiPlease(var fileUpdated) async {
  //   String url = "http://10.0.2.2:8000/jogos";
  //   var uri = Uri.parse(url);

  //   var body = json.decode(fileUpdated);
  //   final jsonString = json.encode(body);
  //   print('WHO ARE YOU? $jsonString');

  //   // final uri = Uri.http(url, '/path');

  //   final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

  //   final response = await http.post(uri, headers: headers, body: jsonString);
  //   print(response);

  //   if (response.toString().isNotEmpty) {
  //     print(response.body);
  //   } else {
  //     print(response.statusCode);
  //   }
  // }

  Future<String> getFilePath(String gameCode) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/" + gameCode + ".json";
    print(filePath);

    return filePath;
  }

  void writeAndSaveFileModel(String gameCode, var fileContents) async {
    print('FILE contents: ${json.encode(fileContents)}');
    final file = File(await getFilePath(gameCode));
    await file.writeAsString(json.encode(fileContents));
    print('TALVEZ TENHA DADO CERTO GUARDAR O ARQUIVO');
  }

  void writeAndSaveFileStars(
      String gameCode, var fileContents, int stars) async {
    fileContents['qtd_estrelinhas'] = stars;
    final file = File(await getFilePath(gameCode));
    await file.writeAsString(json.encode(fileContents));
    print('TALVEZ TENHA DADO CERTO ESTRELAS $fileContents');
  }

  void writeAndSaveFileData(String gameCode, var fileContents) async {
    fileContents['dataAtualizacaoForca'] = now.toString().substring(0, 10);
    final file = File(await getFilePath(gameCode));
    await file.writeAsString(json.encode(fileContents));
    print('TALVEZ TENHA DADO CERTO DATA $fileContents');
  }

  void createNewGameInFile(String fileCode, var fileContents) async {
    List teste = fileContents.jogos;
    DateTime endDateTime = DateTime(now.year, now.month, now.day + 6);
    print(endDateTime);
    print(endDateTime.toString().substring(0, 10));
    var newGame = {
      'codigo': '33333j',
      'nome_fantasia': 'O desespero dos feijoes',
      'disciplina': 'Biologia',
      'professor': 'eu o chapolin colorado',
      'datainicio': now.toString().substring(0, 10),
      'datafim': endDateTime.toString().substring(0, 10),
      'forca': 100,
      'dataAtualizacaoForca': now.toString().substring(0, 10),
      'qtd_estrelinhas': 0,
    };

    // print('NOVA CLASSE DE JOGO ${Jogos.fromJson(newGame)}');
    teste.add(Jogos.fromJson(newGame));
    fileContents.jogos = teste;
    // print('FILE CONTENTS1 ${json.encode(fileContents)}');
    // print('NEW GAME: ${json.encode(newGame)}');
    // print('TESTE APPEND ${json.encode(teste)}');

    final file = File(await getFilePath(fileCode));
    await file.writeAsString(json.encode(fileContents));
    // Fazer postRequest para o servidor gamesdata.json = ;
    // updateApiPlease(json.encode(teste));
    print('TALVEZ TENHA DADO CERTO NEW GAME $fileContents');
  }

  void readFile(String gameCode) async {
    File file = File(await getFilePath(gameCode));
    String contents = await file.readAsString();
    json.decode(contents);
    print(contents);
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
                        const SizedBox(height: 12),
                        FloatingActionButton.extended(
                          onPressed: () {
                            print('TESTE ${snapshot.data!.jogos![0]}');
                            writeAndSaveFileModel(
                                'gamesdata', snapshot.data!.jogos!);
                          },
                          label: const Text('SALVAR E ESCREVER MODEL'),
                          backgroundColor: Colors.green[700],
                        ),
                        const SizedBox(height: 12),
                        FloatingActionButton.extended(
                          onPressed: () {
                            writeAndSaveFileStars(_gameCode,
                                snapshot.data!.jogos![0].toJson(), 222);
                          },
                          label: const Text('SALVAR E ESCREVER STARS'),
                          backgroundColor: Colors.green[700],
                        ),
                        const SizedBox(height: 12),
                        FloatingActionButton.extended(
                          onPressed: () {
                            writeAndSaveFileData(
                                _gameCode, snapshot.data!.jogos![0].toJson());
                          },
                          label: const Text('SALVAR E ESCREVER DATA'),
                          backgroundColor: Colors.green[700],
                        ),
                        const SizedBox(height: 12),
                        FloatingActionButton.extended(
                          onPressed: () {
                            createNewGameInFile('gamesdata', snapshot.data);
                            // Descobri um jeito de passar os dados que estão no arquivo local
                            // no lugar de snapshot.data pois isso vem do server agora e o server
                            // não atualiza o arquivo local a medida que novos jogos surgem. Passando
                            // o conteudo do arquivo local (gamesdata.json) e fazendo a conversão
                            // desse mapa para o modelo de GamesModel creio que seja possivel atualizar
                            // e acrescentar novos jogos sem perder nenhum dado.
                            print(snapshot.data!.jogos);
                          },
                          label: const Text('CRIAR NOVO JOGO'),
                          backgroundColor: Colors.black,
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
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            onPressed: () {
              readFile(_gameCode);
            },
            label: const Text('LER'),
            backgroundColor: Colors.purple[700],
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
