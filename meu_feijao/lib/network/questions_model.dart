// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class QuestionModel {
  List<Questoes>? questoes;

  QuestionModel({this.questoes});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    if (json['questoes'] != null) {
      questoes = <Questoes>[];
      json['questoes'].forEach((v) {
        questoes!.add(Questoes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questoes != null) {
      data['questoes'] = questoes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questoes {
  String? dataResposta;
  int? tentativas;
  int? id;
  String? question;
  List<String>? options;
  int? answerIndex;
  int? usado;
  String? comentario;

  Questoes(
      {this.dataResposta,
      this.tentativas,
      this.id,
      this.question,
      this.options,
      this.answerIndex,
      this.usado,
      this.comentario});

  Questoes.fromJson(Map<String, dynamic> json) {
    dataResposta = json['data_resposta'];
    tentativas = json['tentativas'];
    id = json['id'];
    question = json['question'];
    options = json['options'].cast<String>();
    answerIndex = json['answer_index'];
    usado = json['usado'];
    comentario = json['comentario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data_resposta'] = dataResposta;
    data['tentativas'] = tentativas;
    data['id'] = id;
    data['question'] = question;
    data['options'] = options;
    data['answer_index'] = answerIndex;
    data['usado'] = usado;
    data['comentario'] = comentario;
    return data;
  }
}

Future<QuestionModel> getFileContents(String gameCode) async {
  File file = File(await getFilePath(gameCode));
  String contents = await file.readAsString();
  QuestionModel fullQuestions = QuestionModel.fromJson(json.decode(contents));
  return fullQuestions;
}

Future<String> getFilePath(String gameCode) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  String filePath = appDocPath + "/questions_" + gameCode + ".json";
  return filePath;
}

Future<void> loadQuestions(String gameCode) async {
  QuestionModel fullQuestions = await getFileContents(gameCode);
  List<Questoes> questoes = fullQuestions.questoes!;
  int i = 0;
  var now = DateTime.now();
  var time = now.toString().substring(0, 10);
  // print('questoes ${json.encode(questoes)}');
  while (i < questoes.length) {
    if (questoes[i].dataResposta != 'nda') {
      if (questoes[i].usado == 0 &&
          time == questoes[i].dataResposta &&
          questoes[i].tentativas! < 20) {
        sampledata.add(questoes[i]);
      }
    } else if (questoes[i].dataResposta == 'nda') {
      sampledata.add(questoes[i]);
    }
    i++;
  }
  sampledata = questoes;
  // print('sample ${json.encode(sampledata)}');
}

List<Questoes> sampledata = [];
