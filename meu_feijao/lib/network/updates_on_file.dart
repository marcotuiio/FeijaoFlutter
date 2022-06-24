import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:feijao_magico_uel/network/games_model.dart';

class UpdateOnFile {
  var now = DateTime.now();

  Future<GamesModel> getFileContents() async {
    File file = File(await getFilePath());
    String contents = await file.readAsString();
    Map<String, dynamic> data = json.decode(contents);
    var fullJson = GamesModel.fromJson(data);
    return fullJson;
  }

  Future<String> getFilePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/gamesdata.json";
    return filePath;
  }

  void writeFile(GamesModel gamesModel) async {
    final file = File(await getFilePath());
    await file.writeAsString(json.encode(gamesModel));
  }

  void setEstrelinhas(int estrelinhas, int gameIndex) async {
    var fullJson = await getFileContents();
    fullJson.jogos![gameIndex].qtdEstrelinhas = estrelinhas;
    writeFile(fullJson);
  }

  void setForca(int forca, int gameIndex) async {
    var fullJson = await getFileContents();
    fullJson.jogos![gameIndex].forca = forca;
    writeFile(fullJson);
  }

  void setDataRega(int gameIndex) async {
    var fullJson = await getFileContents();
    fullJson.jogos![gameIndex].dataAtualizacaoForca =
        now.toString().substring(0, 10);
    writeFile(fullJson);
  }
}
