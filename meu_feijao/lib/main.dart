import 'dart:convert';
import 'dart:io';
import 'package:feijao_magico_uel/components/bottomnav_theme.dart';
import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:feijao_magico_uel/pages/selec_jogo.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const PeDeFeijaoAPP());
}

class PeDeFeijaoAPP extends StatefulWidget {
  const PeDeFeijaoAPP({
    Key? key,
  }) : super(key: key);

  @override
  State<PeDeFeijaoAPP> createState() => _PeDeFeijaoAPPState();
}

class _PeDeFeijaoAPPState extends State<PeDeFeijaoAPP> {
  // ignore: prefer_typing_uninitialized_variables
  var ghost = {"jogos": []};

  @override
  void initState() {
    super.initState();
    // checkFileEmpty();
    checkJsonEmpty();
  }

  Future<String> getFilePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/gamesdata.json";

    return filePath;
  }

  void checkJsonEmpty() async {
    File file = File(await getFilePath());
    var jogos = GamesModel.fromJson(ghost);
    if (file.existsSync()) {
      String contents = await file.readAsString();
      if (contents.isEmpty) {
        await file.writeAsString(json.encode(jogos));
      }
    } else {
      file.createSync();
      await file.writeAsString(json.encode(jogos));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData base = ThemeData.dark();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        bottomNavigationBarTheme: bottomNavigationBarTheme,
        textTheme: _appTextTheme(base.textTheme),
      ),
      debugShowCheckedModeBanner: false,
      home: const SelecionarJogo(),
    );
  }
}

TextTheme _appTextTheme(TextTheme base) {
  return base.copyWith(
    headline1: base.headline1?.copyWith(
      fontWeight: FontWeight.w500,
    ),
    subtitle1: base.subtitle1?.copyWith(
      fontSize: 18,
      color: Colors.black45,
    ),
    caption: base.caption?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodyText1: base.bodyText1?.copyWith(
      fontSize: 17,
      color: Colors.grey,
    ),
    button: base.button?.copyWith(
      letterSpacing: 3,
      fontSize: 16,
    ),
  );
}
