import 'package:feijao_magico_uel/components/botoes_body.dart';
import 'package:feijao_magico_uel/components/bottom_bar.dart';
import 'package:feijao_magico_uel/pages/selec_jogo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.black87,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SelecionarJogo(),
              ),
            );
          },
        ),
        elevation: 0,
        title: const Text(
          '~~ Feijão Mágico ~~',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      body: BotoesMainPage(),
      bottomNavigationBar: const NavBarBottom(),
    );
  }
}
