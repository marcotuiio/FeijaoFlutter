// ignore_for_file: must_be_immutable

import 'package:feijao_magico_uel/Storages/createfile.dart';
import 'package:feijao_magico_uel/Storages/storages.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class CadastroInicial extends StatefulWidget {
  Storage? storage = Storage(fileofInterest: 'name.json');

  CadastroInicial({Key? key}) : super(key: key);

  @override
  _CadastroInicialState createState() => _CadastroInicialState();
}

class _CadastroInicialState extends State<CadastroInicial> {
  late File namejsonFile;
  // late Directory namedir;
  late Map<String, dynamic> namefileContent;
  String fileName = 'name.json';
  bool namefileExists = false;

  String namedata = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    //Verifica existência do arquivo fileX.json [no caso: name.json]
    widget.storage!.checkExist().then((bool existfile) {
      setState(() => namefileExists = existfile);
    });
    widget.storage!.nameJsonFile().then((File namefile) {
      setState(() {
        namejsonFile = namefile;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> writeJson(String name) async {
    String namedata = '{"nome": "$name"}';
    Map<String, dynamic> content = json.decode(namedata);

    if (namefileExists) {
      namejsonFile.writeAsStringSync(json.encode(content));
      // Map<String, dynamic> jsonFileContent =
      //     await json.decode(namejsonFile.readAsStringSync());
      // var newobject = jsonFileContent.entries.map((entry) {
      //   return entry.value;
      // }).toList();
    } else {
      final dir = await getApplicationDocumentsDirectory();
      createFile(content, dir, fileName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              const Text(
                'Olá Estudante.',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bem Vindo ao jogo Feijões Mágicos!!',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                width: 350,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/livroplant.png'),
                  ),
                ),
              ),
              const SizedBox(height: 34),
              const Text(
                'Informe seu nome:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Nome',
                  labelText: 'NOME',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blue[800],
                  ),
                  border: const OutlineInputBorder(),
                  fillColor: Colors.black12,
                  filled: true,
                ),
              ),
              const SizedBox(height: 64),
              ElevatedButton.icon(
                onPressed: () {
                  writeJson(_controller.text);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.save),
                label: const Text('Confirmar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
