// ignore_for_file: avoid_print
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

  //Buscando conteudo do arquivo json
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/files/questoes_index.json');
    final data = await json.decode(response);
    setState(() {
      _items = data['questao'];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> vetor1 = [1, 2, 3, 4, 5, 6, 7];
    final list1 = vetor1;
    final number1 = list1..shuffle();

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