import 'dart:convert';
import 'dart:io';
import 'package:feijao_magico_uel/network/questions_model.dart';
import 'package:path_provider/path_provider.dart';

class UpdateQuestions {
  var now = DateTime.now();

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

  void writeFile(QuestionModel questModel, String gameCode) async {
    final file = File(await getFilePath(gameCode));
    await file.writeAsString(json.encode(questModel));
  }

  Future<List<Questoes>> loadQuestions(String gameCode) async {
    QuestionModel fullQuestions = await getFileContents(gameCode);
    List<Questoes> questoes = fullQuestions.questoes!;
    return questoes;
  }

  Future<void> setTentativas(String gameCode, int tentativas, int index) async {
    QuestionModel fullQuestions = await getFileContents(gameCode);
    fullQuestions.questoes![index].tentativas = tentativas;
    writeFile(fullQuestions, gameCode);
  }

  Future<void> setUsado(String gameCode, int index) async {
    QuestionModel fullQuestions = await getFileContents(gameCode);
    fullQuestions.questoes![index].usado = 1;
    writeFile(fullQuestions, gameCode);
  }

  Future<void> setDataResposta(String gameCode, int index) async {
    QuestionModel fullQuestions = await getFileContents(gameCode);
    fullQuestions.questoes![index].dataResposta =
        now.toString().substring(0, 10);
    writeFile(fullQuestions, gameCode);
  }
}
