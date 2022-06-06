// ignore_for_file: avoid_print

import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:flutter/material.dart';

Widget cardSelectGame(
    AsyncSnapshot<GamesModel> snapshot, BuildContext context) {
  return Expanded(
    child: ListView.builder(
      itemCount: snapshot.data!.jogos!.length,
      itemBuilder: (context, index) {
        return Column(children: <Widget>[
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  print(snapshot.data!.jogos![index].toJson());
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
        ]);
      },
    ),
  );
}
