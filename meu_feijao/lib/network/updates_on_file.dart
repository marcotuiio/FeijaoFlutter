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
    int aux = fullJson.jogos![gameIndex].qtdEstrelinhas!;
    fullJson.jogos![gameIndex].qtdEstrelinhas = aux + estrelinhas;
    writeFile(fullJson);
  }

  void setForcaPlus(int forca, int gameIndex) async {
    var fullJson = await getFileContents();
    if (fullJson.jogos![gameIndex].forca! + forca > 100) {
      fullJson.jogos![gameIndex].forca = 100;
    } else {
      fullJson.jogos![gameIndex].forca =
          fullJson.jogos![gameIndex].forca! + forca;
    }
    writeFile(fullJson);
  }

  void setForcaMinus(int forca, int gameIndex) async {
    var fullJson = await getFileContents();
    if (fullJson.jogos![gameIndex].forca! - forca <= 0) {
      fullJson.jogos![gameIndex].forca = 0;
    } else {
      fullJson.jogos![gameIndex].forca =
          fullJson.jogos![gameIndex].forca! - forca;
    }
    writeFile(fullJson);
  }

  void setDataRega(int gameIndex) async {
    var fullJson = await getFileContents();
    fullJson.jogos![gameIndex].dataAtualizacaoForca =
        now.toString().substring(0, 10);
    writeFile(fullJson);
  }
}
