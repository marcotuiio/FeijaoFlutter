import 'package:feijao_magico_uel/network/questions_model.dart';
import 'package:feijao_magico_uel/network/update_quest.dart';
import 'package:feijao_magico_uel/network/updates_on_file.dart';
import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:feijao_magico_uel/pages/selec_jogo.dart';
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
  UpdateQuestions updateQuestions = UpdateQuestions();
  late int forca;
  late int currentIndex;
  late Jogos currentGame;

  @override
  void initState() {
    super.initState();
    forca = widget.currentGame.forca as int;
    currentIndex = widget.index;
    currentGame = widget.currentGame;
    // checkJsonEmpty(currentGame.codigo!);
    if (isEmpty == 2) {
      prepareToRespond(currentGame.codigo!);
      loadQuestions(currentGame.codigo!);
    } 
  }

  // Future<String> getFilePath(String code) async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String appDocPath = appDocDir.path;
  //   String filePath = appDocPath + "/questions_" + code + ".json";
  //   return filePath;
  // }

  // void checkJsonEmpty(String code) async {
  //   File file = File(await getFilePath(code));
  //   if (!file.existsSync()) {
  //     setState(() {
  //       isActiveButtonRega = true;
  //       isActiveButtonStars = true;
  //       auxLen = 9;
  //       isEmpty = 1;
  //     });

  //   } else {
  //     setState(() {
  //       isEmpty = 2;
  //     });
  //   }
  // }

  Future<void> prepareToRespond(String gameCode) async {
    UpdateOnFile updates = UpdateOnFile();
    DateTime now = DateTime.now();
    var yesterday = DateTime(now.year, now.month, now.day - 1);
    var today = now.toString().substring(0, 10);
    var dataRega = currentGame.dataAtualizacaoForca!;

    // REGAR
    if (today == dataRega) {
      setState(() {
        isActiveButtonRega = false;
        updates.setTentativaForca(currentIndex, 0);
      });
    } else if (currentGame.tentativasForca == 0) {
      isActiveButtonRega = true;
      auxLen = 1;
    }

    // ESTRELINHAS
    if (today == currentGame.dataAtual) {
      if (currentGame.tentativasEstrelas! < 9) {
        isActiveButtonStars = true;
        auxLen = 9 - currentGame.tentativasEstrelas!;
      } else {
        updates.setDataAtual(currentIndex, 1);
        updates.setTentativaEstrelas(currentIndex);
        isActiveButtonStars = false;
      }
    } else if (currentGame.dataAtual == yesterday.toString().substring(0, 10) &&
        currentGame.tentativasEstrelas! < 9) {
      updates.setDataAtual(currentIndex, 0);
      updates.setTentativaEstrelas(currentIndex);
      isActiveButtonStars = true;
      auxLen = 9;
    }

    // FIM DO JOGO
    if (int.parse(today.substring(8, 10)) >=
        int.parse(currentGame.datafim!.substring(8, 10))) {
      if (int.parse(today.substring(5, 7)) >=
          int.parse(currentGame.datafim!.substring(5, 7))) {
        if (int.parse(today.substring(0, 4)) >=
            int.parse(currentGame.datafim!.substring(0, 4))) {
          isActiveButtonRega = false;
          isActiveButtonStars = false;
          // updar relatorio das questoes 
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    late String background;
    if (forca >= 90) {
      //crescimento normal
      background = 'assets/saudavel.png';
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
          fit: BoxFit.contain,
        ),
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                Text(
                  '${currentGame.qtdEstrelinhas}',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.yellow[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  '${currentGame.forca}',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.red[700],
                    fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }
}

