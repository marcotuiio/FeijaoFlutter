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

  Future<void> setEstrelinhas(int estrelinhas, int gameIndex) async {
    var fullJson = await getFileContents();
    int aux = fullJson.jogos![gameIndex].qtdEstrelinhas!;
    fullJson.jogos![gameIndex].qtdEstrelinhas = aux + estrelinhas;
    print(fullJson.jogos![gameIndex].qtdEstrelinhas);
    writeFile(fullJson);
  }

  Future<void> setForcaPlus(int forca, int gameIndex) async {
    var fullJson = await getFileContents();
    if (fullJson.jogos![gameIndex].forca! + forca > 100) {
      fullJson.jogos![gameIndex].forca = 100;
    } else {
      fullJson.jogos![gameIndex].forca =
          fullJson.jogos![gameIndex].forca! + forca;
    }
    print(fullJson.jogos![gameIndex].forca);
    writeFile(fullJson);
  }

  Future<void> setForcaMinus(int forca, int gameIndex) async {
    var fullJson = await getFileContents();
    if (fullJson.jogos![gameIndex].forca! - forca <= 0) {
      fullJson.jogos![gameIndex].forca = 0;
    } else {
      fullJson.jogos![gameIndex].forca =
          fullJson.jogos![gameIndex].forca! - forca;
    }
    print('forca $forca');
    print('forca atual ${fullJson.jogos![gameIndex].forca}');
    writeFile(fullJson);
  }

  Future<void> setDataRega(int gameIndex) async {
    var fullJson = await getFileContents();
    fullJson.jogos![gameIndex].dataAtualizacaoForca =
        now.toString().substring(0, 10);
    print('data rega');
    writeFile(fullJson);
  }

  Future<void> setDataAtual(int gameIndex, int days) async {
    var fullJson = await getFileContents();
    var aux = DateTime(now.year, now.month, now.day + days);
    fullJson.jogos![gameIndex].dataAtual = aux.toString().substring(0, 10);
    writeFile(fullJson);
  }

  Future<void> plusTentativaEstrelas(int gameIndex) async {
    var fullJson = await getFileContents();
    fullJson.jogos![gameIndex].tentativasEstrelas =
        fullJson.jogos![gameIndex].tentativasEstrelas! + 1;
    writeFile(fullJson);
  }

  Future<void> setTentativaEstrelas(int gameIndex) async {
    var fullJson = await getFileContents();
    fullJson.jogos![gameIndex].tentativasEstrelas = 0;
    writeFile(fullJson);
  }

  Future<void> setTentativaForca(int gameIndex, int toSet) async {
    var fullJson = await getFileContents();
    fullJson.jogos![gameIndex].tentativasForca = toSet;
    writeFile(fullJson);
  }
}
