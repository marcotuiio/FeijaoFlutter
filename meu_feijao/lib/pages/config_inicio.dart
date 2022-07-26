// ignore_for_file: avoid_unnecessary_containers
import 'package:feijao_magico_uel/pages/selec_jogo.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class CadastroInicial extends StatefulWidget {
  const CadastroInicial({Key? key}) : super(key: key);

  @override
  _CadastroInicialState createState() => _CadastroInicialState();
}

class _CadastroInicialState extends State<CadastroInicial> {
  String _name = '';

  @override
  void initState() {
    super.initState();
  }

  Future<String> getFilePathTXT() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/cadastro.txt";
    return filePath;
  }

  void readFile() async {
    File file = File(await getFilePathTXT());
    String contents = await file.readAsString();
    setState(() {
      _name = contents;
    });
  }

  void writeFile() async {
    File file = File(await getFilePathTXT());
    file.writeAsString(_name);
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
              const SizedBox(height: 10),
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
              const SizedBox(height: 5),
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
              const SizedBox(height: 18),
              const Text(
                'Informe seu nome:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              textFiledViewName(),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  writeFile();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelecionarJogo(),
                    ),
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text('Confirmar'),
              ),
              Text(
                _name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFiledViewName() {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
            hintText: "Cadastre seu Nome",
            labelText: "NOME",
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.blue[800],
            ),
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.all(8),
            fillColor: Colors.black12,
            filled: true,
          ),
          onSubmitted: (value) {
            setState(() {
              _name = value;
            });
          },
        ),
      ),
    );
  }
}
