// ignore_for_file: avoid_print, avoid_unnecessary_containers
import 'dart:io';

import 'package:feijao_magico_uel/components/quiz/quiz_init.dart';
import 'package:feijao_magico_uel/constants.dart';
import 'package:feijao_magico_uel/network/question_net.dart';
import 'package:feijao_magico_uel/network/questions_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class RespQuestoes extends StatefulWidget {
  final String code;
  final int index;
  const RespQuestoes({required this.code, required this.index, Key? key})
      : super(key: key);

  @override
  _RespQuestoesState createState() => _RespQuestoesState();
}

class _RespQuestoesState extends State<RespQuestoes> {
  bool isButtonActive = false;
  late Future<QuestionModel> questionsObjects;
  String _key = '';
  late int _currentIndex;
  late String _name = '';
  // List _items = [];
  // late List<dynamic> questArr = List<dynamic>.filled(1, 0, growable: true);

  @override
  void initState() {
    super.initState();
    _key = widget.code;
    _currentIndex = widget.index;
    questionsObjects = NetworkQuestion().getQuestionModel(gameCode: _key);
    questionsObjects.then((value) {
      print(value.questoes!.length);
      print(value.questoes![0].question);
    });
    readFileTXT();
    // readJsonQuest().then((List<dynamic> fquestArr) {
    //   setState(() {
    //     questArr = fquestArr;
    //   });
    // });
  }

  //Buscando conteudo do arquivo json
  // Future<List<dynamic>> readJsonQuest() async {
  //   final String response =
  //       await rootBundle.loadString('assets/questoes_index.json');
  //   final data = await json.decode(response);
  //   final datalength = data['questao'].length;
  //   List<dynamic> questArr = List<dynamic>.filled(datalength, 0);
  //   List<dynamic> number1 = List<dynamic>.filled(datalength, 0);
  //   setState(() {
  //     _items = data['questao'];
  //     for (int i = 0; i < datalength; i++) {
  //       questArr[i] = int.parse(data['questao'][i]['id_questao']);
  //     }
  //     number1 = questArr..shuffle();
  //   });
  //   return number1;
  // }

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

  void saveQuestionModel(String gameCode, var fileContents) async {
    print('FILE contents: ${json.encode(fileContents)}');
    final file = File(await getFilePath(gameCode));
    QuestionModel aux = fileContents;
    if (file.existsSync() == false) {
      file.writeAsString(json.encode(aux));
      print('ARQUIVO SALVO PELA PRIMEIRA VEZ');
    } 
    print('ARQUIVO JA EXISTE');
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
    print(filePath);
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
              'Olá, $_name',
              style: const TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            // Text(
            //   '$questArr',
            //   style: const TextStyle(
            //     fontSize: 20,
            //   ),
            // ),
            const SizedBox(height: 10),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       primary: Colors.blue[600], // Background color
            //       onPrimary: Colors.white),
            //   child: const Text('CARREGAR INDEX'),
            //   onPressed: () {},
            // ),
            const SizedBox(height: 10),
            // _items.isNotEmpty
            //     ? Expanded(
            //         child: ListView.builder(
            //             itemCount: _items.length,
            //             itemBuilder: (context, index) {
            //               return Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: <Widget>[
            //                   ElevatedButton(
            //                     onPressed: () {
            //                       setState(() {
            //                         List<dynamic> vetor =
            //                             _items[index]["id_questao"];
            //                         final list = vetor;
            //                         final number = list..shuffle();
            //                         print('$number');
            //                       });
            //                     },
            //                     child: const Text('Teste'),
            //                   ),
            //                 ],
            //               );
            //             }),
            //       )
            //     : Container(),
            // const SizedBox(height: 1),
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
                          InkWell(
                            onTap: () async {
                              setState(() {
                                isButtonActive = true;
                              });
                              saveQuestionModel(_key, snapshot.data);
                              loadQuestions(_key);
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
                                "ESTÁ PREPARADO???",
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          InkWell(
                            onTap: isButtonActive
                                ? () {
                                    setState(() {
                                      isButtonActive = false;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuizScreen(
                                          code: _key,
                                          index: _currentIndex,
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            child: Container(
                              width: 195,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                gradient: kPrimaryGradient,
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

//Repositório utilizado de base
//https://github.com/samir-benabadji/Quiz-App-




              