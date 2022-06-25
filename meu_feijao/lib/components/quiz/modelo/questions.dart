import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Question {
  // final String code;
  final int id, answer;
  final String question;
  //final String comentario;
  final List<String> options;

  Question({
    // required this.code,
    required this.id,
    required this.question,
    required this.answer,
    required this.options,
    //required this.comentario,
  });

  Future<Map<String, dynamic>> getFileContents(String gameCode) async {
    File file = File(await getFilePath(gameCode));
    String contents = await file.readAsString();
    return json.decode(contents);
  }

  Future<String> getFilePath(String gameCode) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/questions_" + gameCode + ".json";
    // print(filePath);
    return filePath;
  }
}

// No arquivo: questoes_respondidas_[codigo do game].json - carregar vetor com dados das
// questões respondidas [ data, id_questao, tentativa] com tipo == “P” {“P” para plantas}
// Verificar se existem questões com data == data de hoje (data do sistema) e (tentativa == 10 ou tentativa ==
// 00)
const List sampledata = [
  {
    "id": 90,
    "question":
        " O organizador de uma competição de lançamento de dardos pretende tornar o campeonato mais competitivo. Pelas regras atuais da competição, numa rodada, o jogador lança 3 dardos e pontua caso acerte pelo menos um deles no alvo. O organizador considera que, em média, os jogadores têm, em cada lançamento, 1/2 de probabilidade de acertar um dardo no alvo. A fim de tornar o jogo mais atrativo, planeja modificar as regras de modo que a probabilidade de um jogador pontuar em uma rodada seja igual ou superior a 9/10. Para isso, decide aumentar a quantidade de dardos a serem lançados em cada rodada. Com base nos valores considerados pelo organizador da competição, a quantidade mínima de dardos que devem ser disponibilizados em uma rodada para tornar o jogo mais atrativo é",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 1, //index vai de 0 a 3
    "comentário": "dica 90"
  },
  {
    "id": 20,
    "question":
        "As relações do Estado brasileiro com o movimento operário e sindical, bem como as políticas públicas voltadas para as questões sociais durante o primeiro governo da Era Vargas (1930-1945), são temas amplamente estudados pela academia brasileira em seus vários aspectos. São também os temas mais lembrados pela sociedade quando se pensa no legado varguista. ?",
    "options": [
      'disseminação de organizações paramilitares inspiradas nos regimes fascistas europeus',
      ' aprovação de normas que buscavam garantir a posse das terras aos pequenos agricultores',
      'criação de um conjunto de leis trabalhistas associadas ao controle das representações sindicais',
      'implementação de um sistema de previdência e seguridade para atender aos trabalhadores rurais.'
    ],
    "answer_index": 2,
    "comentário": "dica 20"
  },
  {
    "id": 30,
    "question": "Qual é o ..questão 30.. ?",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 2,
    "comentário": "dica 30"
  },
  {
    "id": 31,
    "question": "Qual é o ..questão 31.. ?",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 3,
    "comentário": "dica 31"
  },
  {
    "id": 33,
    "question": "Qual é o ..questão 33.. ?",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 2,
    "comentário": "dica 33"
  },
  {
    "id": 61,
    "question": "Qual é o ..questão 60.. ?",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 3,
    "comentário": "dica 61"
  },
  {
    "id": 10,
    "question": "Qual é o .... ?",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 0,
    "comentário": "dica 10"
  }
];
