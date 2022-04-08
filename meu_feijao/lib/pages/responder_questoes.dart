// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable
import 'package:feijao_magico_uel/components/quiz/quiz_init.dart';
import 'package:feijao_magico_uel/constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
//import 'package:get/get.dart';

class Questoes extends StatefulWidget {
  const Questoes({Key? key}) : super(key: key);

  @override
  _QuestoesState createState() => _QuestoesState();
}

class _QuestoesState extends State<Questoes> {
  List _items = [];
  //late List<dynamic> quest_arr;
  List<dynamic> number1 = List<dynamic>.filled(1,0, growable: true);

  @override
  void initState() {
    super.initState();
    readJson().then((List<dynamic> fquest_arr) {
      setState(() {
        List<dynamic> quest_arr = fquest_arr;
        number1 = quest_arr..shuffle();
        print('new order');
        print(number1);
      });
    });
  }

  //Buscando conteudo do arquivo json
  Future<List<dynamic>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/questoes_index.json');
    final data = await json.decode(response);
    // print('imprimindo data');
    // print(data['questao']);
    final datalength = data['questao'].length;
    List<dynamic> quest_arr = List<dynamic>.filled(datalength, 0);
    List<dynamic> number1 = List<dynamic>.filled(datalength, 0);
    setState(() {
      _items = data['questao'];
      for (int i = 0; i < datalength; i++) {
        quest_arr[i] = int.parse(data['questao'][i]['id_questao']);
        print(quest_arr[i]);
      }
      number1 = quest_arr..shuffle();
    });
    return number1;
  }

  @override
  Widget build(BuildContext context) {
    final number1 = readJson();
    
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
            const Text(
              'Olá, [nome].',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '$number1',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue[600], // Background color
                  onPrimary: Colors.white),
              child: const Text('CARREGAR INDEX'),
              onPressed: readJson,
            ),
            const SizedBox(height: 10),
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    List<dynamic> vetor =
                                        _items[index]["id_questao"];
                                    final list = vetor;
                                    final number = list..shuffle();
                                    print('$number');
                                  });
                                },
                                child: const Text(
                                    'Teste'), //'$number' nao funciona
                              ),
                            ],
                          );
                        }),
                  )
                : Container(),
            const SizedBox(height: 1),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizScreen()),
                );
              },
              child: Container(
                width: 150,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  gradient: kPrimaryGradient,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Text(
                  "Começar a Responder",
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.black),
                ),
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

//colocar botão de sair em quizscreen() e em score_screen()