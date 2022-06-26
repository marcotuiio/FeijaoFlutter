// ignore_for_file: avoid_print

import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:feijao_magico_uel/pages/responder_questoes.dart';
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
                    context, currentIndex, currentGame, updates),
              );
              print('I was here - usar estrelas');
            },
          ),
          label: "Usar Estrelas",
        ),
        BottomNavigationBarItem(
            icon: IconButton(
              iconSize: 40,
              color: Colors.black,
              icon: const Icon(Icons.opacity),
              onPressed: () {
                print('I was here - questoes');
                //Navigator.pushNamed(context, '/questoes');
              },
            ),
            label: "Regar"),
        BottomNavigationBarItem(
          icon: IconButton(
            iconSize: 40,
            color: Colors.black,
            icon: const Icon(Icons.book_online_outlined),
            onPressed: () {
              print('I was here - obter estrelas');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RespQuestoes(
                    code: _code,
                    index: currentIndex,
                  ),
                ),
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
          'Tem certeza que deseja consumir TODAS SUAS ESTRELAS (${atual.qtdEstrelinhas}) para recuper força (${atual.forca})?',
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
        onPressed: () {
          var auxStars = -(atual.qtdEstrelinhas!);
          var auxStars2 = auxStars * 2;
          print(auxStars);
          print(auxStars2);
          updates.setForcaPlus(auxStars2, currentIndex);
          updates.setEstrelinhas(-(atual.qtdEstrelinhas!), currentIndex);
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
