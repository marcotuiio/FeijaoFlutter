// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:feijao_magico_uel/Storages/storages.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

class CodigoJogo extends StatefulWidget {
  Storage? storage = Storage(fileofInterest: 'name.json');

  CodigoJogo({Key? key}) : super(key: key);

  @override
  _CodigoJogoState createState() => _CodigoJogoState();
}

class _CodigoJogoState extends State<CodigoJogo> {
  TextEditingController controller = TextEditingController();

  late File namejsonFile;
  bool namefileExists = false;
  late Map<String, dynamic> namefileContent;
  List _nameList = [];
  String namedata = '';

  @override
  void initState() {
    super.initState();
    namefileExists = true; //forcei existência do arq. Modificar!!!!!!!
    widget.storage!.nameJsonFile().then((File namefile) {
      setState(() {
        namejsonFile = namefile;
      });
      readJson(namejsonFile);
    });
  }

  Future<String> readJson(File namejsonFile) async {
    if (namefileExists) {
      Map<String, dynamic> jsonFileContent =
          await json.decode(namejsonFile.readAsStringSync());
      var newobject = jsonFileContent.entries.map((entry) {
        return entry.value;
      }).toList();
      setState(() {
        _nameList = newobject;
        namedata = _nameList.join();
      });
    }
    return namedata;
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
              const SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Olá, $namedata',
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 54),
              const Text(
                'Insira o código do novo jogo:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Código',
                  labelText: 'CÓDIGO DO JOGO',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blue[800],
                  ),
                  border: const OutlineInputBorder(),
                  fillColor: Colors.black12,
                  filled: true,
                ),
                maxLength: 5,
              ),
              const SizedBox(height: 70),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.wrong_location),
                label: const Text('Sair'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
