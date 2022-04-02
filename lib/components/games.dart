// To parse this JSON data, do
//
//     final games = gamesFromJson(jsonString);

//////////////////////////////////////////////////////////////////////////////
//
// const jsonArray = '''
//   [{"text": "foo", "value": 1, "status": true},
//    {"text": "bar", "value": 2, "status": false}]
// ''';
// final List<dynamic> dynamicList = jsonDecode(jsonArray);
// final List<Map<String, dynamic>> fooData =
//     List.from(dynamicList.where((x) => x is Map && x['text'] == 'foo'));
// print(fooData); // [{text: foo, value: 1, status: true}]
//
/////////////////////////////////////////////////////////////////////////////
// To parse this JSON data, do
//
//     final games = gamesFromJson(jsonString);

import 'dart:convert';

Games gamesFromJson(String str) => Games.fromJson(json.decode(str));

String gamesToJson(Games data) => json.encode(data.toJson());

class Games {
  Games({
    required this.jogos,
  });

  List<Jogo> jogos;

  factory Games.fromJson(Map<String, dynamic> json) => Games(
        jogos: List<Jogo>.from(json["jogos"].map((x) => Jogo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jogos": List<dynamic>.from(jogos.map((x) => x.toJson())),
      };
}

class Jogo {
  Jogo({
    required this.codigo,
    required this.nomeFantasia,
    required this.disciplina,
    required this.professor,
    required this.datainicio,
    required this.datafim,
    required this.forca,
    required this.dataAtualizacaoForca,
    required this.qtdEstrelinhas,
  });

  String codigo;
  String nomeFantasia;
  String disciplina;
  String professor;
  DateTime datainicio;
  DateTime datafim;
  String forca;
  DateTime dataAtualizacaoForca;
  String qtdEstrelinhas;

  factory Jogo.fromJson(Map<String, dynamic> json) => Jogo(
        codigo: json["codigo"],
        nomeFantasia: json["nome_fantasia"],
        disciplina: json["disciplina"],
        professor: json["professor"],
        datainicio: DateTime.parse(json["datainicio"]),
        datafim: DateTime.parse(json["datafim"]),
        forca: json["forca"],
        dataAtualizacaoForca: DateTime.parse(json["dataAtualizacaoForca"]),
        qtdEstrelinhas: json["qtd_estrelinhas"],
      );

  Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "nome_fantasia": nomeFantasia,
        "disciplina": disciplina,
        "professor": professor,
        "datainicio":
            "${datainicio.year.toString().padLeft(4, '0')}-${datainicio.month.toString().padLeft(2, '0')}-${datainicio.day.toString().padLeft(2, '0')}",
        "datafim":
            "${datafim.year.toString().padLeft(4, '0')}-${datafim.month.toString().padLeft(2, '0')}-${datafim.day.toString().padLeft(2, '0')}",
        "forca": forca,
        "dataAtualizacaoForca":
            "${dataAtualizacaoForca.year.toString().padLeft(4, '0')}-${dataAtualizacaoForca.month.toString().padLeft(2, '0')}-${dataAtualizacaoForca.day.toString().padLeft(2, '0')}",
        "qtd_estrelinhas": qtdEstrelinhas,
      };
}
