// ignore_for_file: avoid_unnecessary_containers
import 'dart:io';
import 'package:feijao_magico_uel/components/quiz/quiz_init.dart';
import 'package:feijao_magico_uel/constants.dart';
import 'package:feijao_magico_uel/network/question_net.dart';
import 'package:feijao_magico_uel/network/questions_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class RespQuestoes extends StatefulWidget {
  final String code;
  final int index;
  final String type;
  final int len;
  const RespQuestoes(
      {required this.code,
      required this.index,
      required this.type,
      this.len = 0,
      Key? key})
      : super(key: key);

  @override
  _RespQuestoesState createState() => _RespQuestoesState();
}

class _RespQuestoesState extends State<RespQuestoes> {
  late Future<QuestionModel> questionsObjects;
  String _currentCode = '';
  late int _currentIndex;
  late String _name = '';
  late String _type = '';
  late int _len;

  @override
  void initState() {
    super.initState();
    _currentCode = widget.code;
    _currentIndex = widget.index;
    _type = widget.type;
    _len = widget.len;
    questionsObjects =
        NetworkQuestion().getQuestionModel(gameCode: _currentCode);
    readFileTXT();
    finalLen = _len;
    print(finalLen);
    print(_type);
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

  Future<void> saveQuestionModel(String gameCode, var fileContents) async {
    // print('FILE contents: ${json.encode(fileContents)}');
    final file = File(await getFilePath(gameCode));
    if (file.existsSync() == false) {
      QuestionModel aux = fileContents;
      List<Questoes> suffleList = aux.questoes!..shuffle();
      aux.questoes = suffleList;
      file.writeAsString(json.encode(aux));
      print('ARQUIVO SALVO PELA PRIMEIRA VEZ');
    } else {
      print('ARQUIVO JA EXISTE');
    }
  }

  Future<Map<String, dynamic>> getFileContents(String gameCode) async {
    File file = File(await getFilePath(gameCode));
    String contents = await file.readAsString();
    return json.decode(contents);
  }

  Future<String> getFilePath(String gameCode) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/questions_" + gameCode + ".json";
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Responder Perguntas'),
        backgroundColor: Colors.green[800],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              'Preparado, $_name ?',
              style: const TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              child: FutureBuilder<QuestionModel>(
                future: questionsObjects,
                builder: (BuildContext context,
                    AsyncSnapshot<QuestionModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null) {
                      // ok
                      return Column(
                        children: <Widget>[
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
                          const SizedBox(height: 40),
                          InkWell(
                            onTap: () async {
                              await saveQuestionModel(
                                  _currentCode, snapshot.data);
                              await loadQuestions(_currentCode);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizScreen(
                                    code: _currentCode,
                                    index: _currentIndex,
                                    type: _type,
                                    len: _len,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 195,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                gradient: kSecodaryGradient,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Text(
                                "COMEÇAR A RESPONDER",
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(color: Colors.black),
                              ),
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
          ],
        ),
      ),
    );
  }
}

int finalLen = 0;

//Repositório utilizado de base
//https://github.com/samir-benabadji/Quiz-App-




              