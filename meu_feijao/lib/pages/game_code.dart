// ignore_for_file: must_be_immutable, avoid_print, avoid_unnecessary_containers

import 'dart:convert';
import 'package:feijao_magico_uel/Storages/createfile.dart';
import 'package:feijao_magico_uel/Storages/storages.dart';
import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class CodigoJogo extends StatefulWidget {
  Storage? storage = Storage(fileofInterest: 'name.json');

  CodigoJogo({Key? key}) : super(key: key);

  @override
  _CodigoJogoState createState() => _CodigoJogoState();
}

class _CodigoJogoState extends State<CodigoJogo> {
  var x = {
    "jogos": [
      {
        "codigo": "As12qw",
        "nome_fantasia": "Equações",
        "disciplina": "Matemática",
        "professor": "Nome Prof",
        "datainicio": "2022-02-24",
        "datafim": "2022-03-01",
        "forca": 90,
        "dataAtualizacaoForca": "2022-03-26",
        "qtd_estrelinhas": 12
      },
      {
        "codigo": "4rASx",
        "nome_fantasia": "Bacias Hidrográficas",
        "disciplina": "Geografia",
        "professor": "Nome Prof ",
        "datainicio": "2022-02-24",
        "datafim": "2022-03-01",
        "forca": 90,
        "dataAtualizacaoForca": "2022-03-26",
        "qtd_estrelinhas": 12
      },
      {
        "codigo": "A12B3",
        "nome_fantasia": "História do Brasil",
        "disciplina": "História",
        "professor": "Nome Prof",
        "datainicio": "2022-02-24",
        "datafim": "2022-03-01",
        "forca": 90,
        "dataAtualizacaoForca": "2022-03-26",
        "qtd_estrelinhas": 12
      }
    ]
  };
  
  String _disc = '';
  String _prof = '';
  String _code = '';
  var now = DateTime.now();

  late File namejsonFile;
  bool namefileExists = false;
  late File indexQuestjsonFile;
  bool indexQuestexists = false;

  late Map<String, dynamic> namefileContent;
  List _nameList = [];
  String namedata = '';
  // ignore: unused_field
  late List _questionList = [];
  late String dir = '';
  late List<dynamic> questArr = List<dynamic>.filled(1, 0, growable: true);

  @override
  void initState() {
    super.initState();
    widget.storage!.localPath.then((String path) {
      setState(() {
        dir = path;
      });
    });
    namefileExists = true; //forcei existência do arq. Modificar!!!!!!!
    widget.storage!.nameJsonFile().then((File namefile) {
      setState(() {
        namejsonFile = namefile;
      });
      readJsonNAME(namejsonFile);
    });
  }

  void newGame(String fileCode, String profName, String discName) async {
    Map<String, dynamic> aux = await getFileContents();
    print('auxnewgame $aux');

    // String contents = aux.replaceAll('},{', '}  {');
    // print('contents: $contents');
    // List jsonList = contents.split('  ');
    // var games = GamesModel.fromJson(json.decode(jsonList.toString()));
    // print('games: $games');
    // var teste = games.jogos!;

    var teste = GamesModel.fromJson(aux);
    var jsonList = teste.jogos!;

    DateTime endDateTime = DateTime(now.year, now.month, now.day + 6);
    var newGame = {
      'codigo': fileCode,
      'nome_fantasia': 'Gramatica',
      'disciplina': discName,
      'professor': profName,
      'datainicio': now.toString().substring(0, 10),
      'datafim': endDateTime.toString().substring(0, 10),
      'forca': 100,
      'dataAtualizacaoForca': now.toString().substring(0, 10),
      'qtd_estrelinhas': 0,
    };

    jsonList.add(Jogos.fromJson(newGame));
    teste.jogos = jsonList;

    // print('NOVA CLASSE DE JOGO ${Jogos.fromJson(newGame)}');
    // teste.add(Jogos.fromJson(newGame));
    // print('FILE CONTENTS1 ${json.encode(fileContents)}');
    // print('NEW GAME: ${json.encode(newGame)}');
    // print('TESTE APPEND ${json.encode(teste)}');

    final file = File(await getFilePath());
    await file.writeAsString(json.encode(teste));
    print('TALVEZ TENHA DADO CERTO NEW GAME $teste');
  }

  Future<String> getFilePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/gamesdata.json";
    print(filePath);
    return filePath;
  }

  Future<Map<String, dynamic>> getFileContents() async {
    File file = File(await getFilePath());
    String contents = await file.readAsString();
    return json.decode(contents);
  }

  Future<String> readJsonNAME(File namejsonFile) async {
    if (namefileExists) {
      Map<String, dynamic> jsonFileContent =
          await json.decode(namejsonFile.readAsStringSync());
      var newobject = jsonFileContent.entries.map((entry) {
        return entry.value;
      }).toList();
      setState(() {
        _nameList = newobject;
        namedata = _nameList.join();
      });
    }
    return namedata;
  }

  //Buscando conteudo do arquivo json
  Future<List<dynamic>> readJsonQuest() async {
    final String response =
        await rootBundle.loadString('assets/questoes_index.json');
    final data = await json.decode(response);
    final datalength = data['questao'].length;
    List<dynamic> questArray = List<dynamic>.filled(datalength, 0);
    List<dynamic> number1 = List<dynamic>.filled(datalength, 0);
    setState(() {
      _questionList = data['questao'];
      for (int i = 0; i < datalength; i++) {
        questArray[i] = int.parse(data['questao'][i]['id_questao']);
      }
      number1 = questArray..shuffle();
    });
    return number1;
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Olá, $namedata',
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
                width: 250,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/livroplant.png'),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Insira os dados do novo jogo:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              textFiledViewCode(),
              const SizedBox(height: 2),
              textFiledViewMateria(),
              const SizedBox(height: 2),
              textFiledViewProf(),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  newGame(_code, _prof, _disc);
                  String questIdfile = _code + '_questIDs.json';
                  print('path = $questIdfile');
                  Storage? storageQuest = Storage(fileofInterest: questIdfile);
                  storageQuest.checkExist().then((bool doesfileexist) {
                    bool questidEXIST = doesfileexist;
                    if (questidEXIST == false) {
                      readJsonQuest().then((List<dynamic> fquestArr) {
                        setState(() {
                          questArr = fquestArr;
                          Map<String, List<dynamic>> questIDmap = {
                            'id_questao': questArr
                          };
                          //Salva arquivo com vetor de questoes ID.
                          createFile(questIDmap, dir, questIdfile);
                        });
                      });
                    }
                  });
                  // Navigator.pop(context);
                },
                icon: const Icon(Icons.check),
                label: const Text('CONFIRMAR'),
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
                    Text(
                      _disc,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      _prof,
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

  Widget textFiledViewProf() {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
            hintText: "Professor",
            labelText: "PROFESSOR DO JOGO",
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.blue[800],
            ),
            prefixIcon: const Icon(Icons.person_add_alt_1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.all(8),
            fillColor: Colors.black12,
            filled: true,
          ),
          onSubmitted: (value) {
            setState(() {
              _prof = value;
            });
          },
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
            });
          },
          // maxLength: 6,
        ),
      ),
    );
  }

  Widget textFiledViewMateria() {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
            hintText: "Disciplina",
            labelText: "DISCIPLINA DO JOGO",
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.blue[800],
            ),
            prefixIcon: const Icon(Icons.subject),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.all(8),
            fillColor: Colors.black12,
            filled: true,
          ),
          onSubmitted: (value) {
            setState(() {
              _disc = value;
            });
          },
        ),
      ),
    );
  }
}
