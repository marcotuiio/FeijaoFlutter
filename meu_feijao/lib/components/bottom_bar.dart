// ignore_for_file: avoid_print

import 'package:feijao_magico_uel/pages/responder_questoes.dart';
import 'package:flutter/material.dart';

class NavBarBottom extends StatelessWidget {
  const NavBarBottom({
    Key? key,
  }) : super(key: key);

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