import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:feijao_magico_uel/pages/responder_questoes.dart';
import 'package:feijao_magico_uel/pages/selec_jogo.dart';
import 'package:flutter/material.dart';
import 'package:feijao_magico_uel/network/updates_on_file.dart';

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
  
  @override
  void initState() {
    super.initState();
    currentGame = widget.atual;
    currentIndex = widget.index;
    _code = currentGame.codigo!;
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
            auxStar = atual.qtdEstrelinhas!;
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
