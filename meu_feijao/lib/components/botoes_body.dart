// ignore_for_file: avoid_print, must_be_immutable

import 'dart:convert';
import 'package:feijao_magico_uel/network/from_server.dart';
import 'package:feijao_magico_uel/network/updates_on_file.dart';
import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:flutter/material.dart';

class BotoesMainPage extends StatefulWidget {
  final Jogos currentGame;
  final int index;
  const BotoesMainPage(
      {required this.currentGame, required this.index, Key? key})
      : super(key: key);

  @override
  State<BotoesMainPage> createState() => _BotoesMainPageState();
}

class _BotoesMainPageState extends State<BotoesMainPage> {
  UpdateOnFile updates = UpdateOnFile();
  var now = DateTime.now();
  late int forca;
  late int currentIndex;
  late Jogos currentGame;

  @override
  void initState() {
    forca = widget.currentGame.forca as int;
    currentIndex = widget.index;
    currentGame = widget.currentGame;
    super.initState();
  }

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
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.orange[900]),
                  onPressed: () {
                    setState(() {
                      // updates.setEstrelinhas(-(600), currentIndex);
                      updates.setForcaMinus(100, currentIndex);
                    });
                  },
                  icon: const Icon(Icons.engineering),
                  label: const Text('Alterar arquivo'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.purple[900]),
                  onPressed: () {
                    print(json.encode(currentGame));
                  },
                  icon: const Icon(Icons.person_outline_sharp),
                  label: const Text('Prova real'),
                ),
                // ElevatedButton.icon(
                //   style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                //   onPressed: () {
                //     print("FULL TIME => $now");
                //     print("TODAY => ${now.toString().substring(0, 10)}");
                //   },
                //   icon: const Icon(Icons.watch),
                //   label: const Text("Get time"),
                // ),
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
