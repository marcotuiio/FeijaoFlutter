import 'dart:io';
import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:feijao_magico_uel/pages/responder_questoes.dart';
import 'package:flutter/material.dart';
import 'package:feijao_magico_uel/network/updates_on_file.dart';
import 'package:path_provider/path_provider.dart';

class NavBarBottom extends StatefulWidget {
  final Jogos atual;
  final int index;
  const NavBarBottom({
    required this.atual,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<NavBarBottom> createState() => _NavBarBottomState();
}

class _NavBarBottomState extends State<NavBarBottom> {
  UpdateOnFile updates = UpdateOnFile();
  late Jogos currentGame;
  late int currentIndex;
  late String _code = '';
  late String dataRega = '';
  DateTime now = DateTime.now();
  late String today = '';
  bool isActiveButtonRega = false;
  bool isActiveButtonStars = false;
  late int auxLen = 0;

  @override
  void initState() {
    super.initState();
    var yesterday = DateTime(now.year, now.month, now.day - 1);
    currentGame = widget.atual;
    currentIndex = widget.index;
    _code = currentGame.codigo!;
    dataRega = currentGame.dataAtualizacaoForca!;
    today = now.toString().substring(0, 10);

    checkJsonEmpty(_code);

    // REGAR
    if (today == dataRega) {
      isActiveButtonRega = false;
      updates.setTentativaForca(currentIndex, 0);
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

    if (int.parse(today.substring(8, 10)) >=
        int.parse(currentGame.datafim!.substring(8, 10))) {
      if (int.parse(today.substring(5, 7)) >=
          int.parse(currentGame.datafim!.substring(5, 7))) {
        if (int.parse(today.substring(0, 4)) >=
            int.parse(currentGame.datafim!.substring(0, 4))) {
          isActiveButtonRega = false;
          isActiveButtonStars = false;
        }
      }
    }
  }

  // 6/7/22 today == dataAtual
  // 7/7/22 dataAtual

  // 7/7/22 today == dataAtual
  // tentativasDiarias = 4

  // 8/7/22 today
  // 7/7/22 dataAtual --> 8/7/22 e tentativasDiarias = 0
  // 7/7/22 yesterday

  Future<String> getFilePath(String code) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/questions_" + code + ".json";
    return filePath;
  }

  void checkJsonEmpty(String code) async {
    File file = File(await getFilePath(code));
    if (!file.existsSync()) {
      setState(() {
        isActiveButtonRega = true;
        isActiveButtonStars = true;
        auxLen = 9;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            iconSize: 40,
            color: Colors.black,
            icon: const Icon(Icons.star_border_outlined),
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(
                  context,
                  currentIndex,
                  currentGame,
                  updates,
                ),
              );
            },
          ),
          label: "Usar Estrelas",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            iconSize: 40,
            color: Colors.black,
            icon: const Icon(Icons.opacity),
            onPressed: isActiveButtonRega
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RespQuestoes(
                          code: _code,
                          index: currentIndex,
                          type: 'R',
                          len: 1,
                        ),
                      ),
                    );
                  }
                : () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialogNaoRega(context),
                    );
                  },
          ),
          label: "Regar",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            iconSize: 40,
            color: Colors.black,
            icon: const Icon(Icons.book_online_outlined),
            onPressed: isActiveButtonStars
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RespQuestoes(
                          code: _code,
                          index: currentIndex,
                          type: 'E',
                          len: auxLen,
                        ),
                      ),
                    );
                  }
                : () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialogNaoStars(context),
                    );
                  },
          ),
          label: "Obter Estrelas",
        ),
      ],
      elevation: 0,
      backgroundColor: Colors.green[800],
    );
  }
}

Widget _buildPopupDialog(
    BuildContext context, int currentIndex, Jogos atual, UpdateOnFile updates) {
  return AlertDialog(
    title: const Text(
      'UTILIZAR ESTRELINHAS',
      style: TextStyle(color: Colors.black),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Tem certeza que deseja consumir o MÁXIMO DE SUAS ESTRELAS (${atual.qtdEstrelinhas}) para recuper força (${atual.forca})?',
        ),
      ],
    ),
    actions: <Widget>[
      ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.cancel_presentation),
        label: const Text('NÃO'),
        style: ElevatedButton.styleFrom(
          primary: Colors.red[700],
          onPrimary: Colors.black,
        ),
      ),
      ElevatedButton.icon(
        onPressed: () async {
          var max = 100 - atual.forca!;
          var limite = atual.qtdEstrelinhas! - max;
          var auxStar = 0;
          var auxForca = 0;

          // tem estrelas exatamente o suficente para chegar com forca em 100 ou estrelas insuficientes
          if (limite <= 0) {
            auxStar = 0;
            auxForca = atual.qtdEstrelinhas!;

          // tem estrelas o suficente para chegar com forca em 100 e sobra
          } else if (limite > 0) {
            auxStar = atual.qtdEstrelinhas! - max;
            auxForca = max;
          }

          await updates.setForcaPlus(auxForca, currentIndex);
          await updates.setEstrelinhas(-(auxStar), currentIndex);
          Navigator.pop(context);
        },
        icon: const Icon(Icons.check_box_outlined),
        label: const Text('SIM'),
        style: ElevatedButton.styleFrom(
          primary: Colors.green[700],
          onPrimary: Colors.black,
        ),
      ),
    ],
  );
}

Widget _buildPopupDialogNaoRega(BuildContext context) {
  return AlertDialog(
    title: const Text(
      'VOCÊ JÁ REGOU HOJE.',
      style: TextStyle(color: Colors.black),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Text(
          'Tente Novamente Amanhã.',
          style: TextStyle(color: Colors.black),
        ),
      ],
    ),
    actions: <Widget>[
      ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.cancel_presentation),
        label: const Text('OK'),
        style: ElevatedButton.styleFrom(
          primary: Colors.red[700],
          onPrimary: Colors.black,
        ),
      ),
    ],
  );
}

Widget _buildPopupDialogNaoStars(BuildContext context) {
  return AlertDialog(
    title: const Text(
      'VOCÊ JÁ RESPONDEU 9 PERGUNTAS HOJE.',
      style: TextStyle(color: Colors.black),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Text(
          'Tente Novamente Amanhã.',
          style: TextStyle(color: Colors.black),
        ),
      ],
    ),
    actions: <Widget>[
      ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.cancel_presentation),
        label: const Text('OK'),
        style: ElevatedButton.styleFrom(
          primary: Colors.red[700],
          onPrimary: Colors.black,
        ),
      ),
    ],
  );
}
