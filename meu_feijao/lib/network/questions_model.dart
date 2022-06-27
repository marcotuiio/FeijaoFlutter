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
  int? tentativas;
  int? id;
  String? question;
  List<String>? options;
  int? answerIndex;
  String? tipo;
  String? comentario;

  Questoes(
      {this.tentativas,
      this.id,
      this.question,
      this.options,
      this.answerIndex,
      this.tipo,
      this.comentario});

  Questoes.fromJson(Map<String, dynamic> json) {
    tentativas = json['tentativas'];
    id = json['id'];
    question = json['question'];
    options = json['options'].cast<String>();
    answerIndex = json['answer_index'];
    tipo = json['tipo'];
    comentario = json['comentario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tentativas'] = tentativas;
    data['id'] = id;
    data['question'] = question;
    data['options'] = options;
    data['answer_index'] = answerIndex;
    data['tipo'] = tipo;
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
  // print(filePath);
  return filePath;
}

Future<void> loadQuestions(String gameCode) async {
  QuestionModel fullQuestions = await getFileContents(gameCode);
  List<Questoes> questoes = fullQuestions.questoes!;
  // print('Antes ${questoes[0].options}');
  sampledata = questoes;
  // print('Depois ${sampledata[0].options}');
}

List<Questoes> sampledata = [];
