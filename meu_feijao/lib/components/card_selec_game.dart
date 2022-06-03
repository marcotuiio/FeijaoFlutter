import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:flutter/material.dart';

Widget cardSelectGame(
    AsyncSnapshot<GamesModel> snapshot, int index, BuildContext context) {
  return Column(
    children: <Widget>[
      const SizedBox(height: 7),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(width: 10),
          ElevatedButton.icon(
            onPressed: () {
              // Navigator.pushNamed(context, '/home');
              Navigator.pop(context);
            },
            icon: const Icon(Icons.gamepad),
            label: Text("${snapshot.data!.jogos![index].nomeFantasia}"),
            style: ElevatedButton.styleFrom(
              primary: Colors.lightGreen,
              onPrimary: Colors.black,
            ),
          ),
        ],
      ),
    ],
  );
}