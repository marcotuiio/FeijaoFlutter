// ignore_for_file: avoid_print

import 'package:feijao_magico_uel/pages/responder_questoes.dart';
import 'package:flutter/material.dart';

class NavBarBottom extends StatefulWidget {
  const NavBarBottom({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBarBottom> createState() => _NavBarBottomState();
}

class _NavBarBottomState extends State<NavBarBottom> {
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
                builder: (BuildContext context) => _buildPopupDialog(context),
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
          label: "Regar"
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            iconSize: 40,
            color: Colors.black,
            icon: const Icon(Icons.book_online_outlined),
            onPressed: () {
              print('I was here - obter estrelas');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Questoes()),                 
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

Widget _buildPopupDialog(BuildContext context) {

  int forca = 45; 
  int estrelas = 28;
  int aux = 0;

  return AlertDialog(
    title: const Text('UTILIZAR ESTRELINHAS'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Text('Tem certeza que deseja consumir TODAS SUAS ESTRELAS para recuper força?'),
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
          // converter para stateful builder --> https://www.youtube.com/watch?v=THMcgdtUtFQ
          if (forca + estrelas > 100){
            aux = 100 - forca;
            // setState(() {
            //   forca = forca + aux;
            //   estrelas = estrelas - aux;
            // });
          }
          // setState(() {
          //   forca = forca + estrelas;
          //   estrelas = 0;
          // });
          print("Estrelas = $estrelas --- Força = $forca");
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
