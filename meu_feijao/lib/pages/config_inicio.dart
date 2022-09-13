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
                'Olá Estudante,',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bem-vindo ao jogo Feijões Mágicos!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
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
              //const NameForm(),
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
            labelStyle: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 21, 192, 92)         
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


class NameForm extends StatefulWidget {
  const NameForm({Key? key}) : super(key: key);

  @override
  NameFormState createState() => NameFormState();
}

class NameFormState extends State<NameForm> {
  final _formKey = GlobalKey<FormState>();

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
                'Olá Estudante,',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bem-vindo ao jogo Feijões Mágicos!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
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
              buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Container (
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child:  Form(
              key: _formKey,
              child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Insira seu nome',
                labelText: 'NOME',
              ),
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'Por favor insira seu nome ';
                }
                return null;
              },
              onFieldSubmitted: (value){
              },
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                }
              },
              child: const Text('Salvar'),
            ),
          )
        ], 
      ),
    );
  }
}