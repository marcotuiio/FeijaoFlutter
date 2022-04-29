// ignore_for_file: must_be_immutable, avoid_print

import 'dart:convert';
import 'package:feijao_magico_uel/Storages/createfile.dart';
import 'package:feijao_magico_uel/Storages/storages.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';

class CodigoJogo extends StatefulWidget {
  Storage? storage = Storage(fileofInterest: 'name.json');

  CodigoJogo({Key? key}) : super(key: key);

  @override
  _CodigoJogoState createState() => _CodigoJogoState();
}

class _CodigoJogoState extends State<CodigoJogo> {
  TextEditingController controller = TextEditingController();

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
              const SizedBox(height: 45),
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
              const SizedBox(height: 54),
              const Text(
                'Insira o código do novo jogo:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Código',
                  labelText: 'CÓDIGO DO JOGO',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blue[800],
                  ),
                  border: const OutlineInputBorder(),
                  fillColor: Colors.black12,
                  filled: true,
                ),
                maxLength: 5,
              ),
              const SizedBox(height: 70),
              ElevatedButton.icon(
                onPressed: () {
                  String questIdfile = controller.text + '_questIDs.json';
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
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.wrong_location),
                label: const Text('CONFIRMAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}