import 'dart:convert';
import 'dart:io';

import 'package:feijao_magico_uel/network/relatorio_model.dart';
import 'package:path_provider/path_provider.dart';

class UpdateRelatorio {
  Future<RelatorioModel> getFileContents(String code) async {
    File file = File(await getFilePath(code));
    String contents = await file.readAsString();
    RelatorioModel fullRelatorio =
        RelatorioModel.fromJson(json.decode(contents));
    return fullRelatorio;
  }

  Future<String> getFilePath(String code) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = appDocPath + "/relatorio_" + code + ".json";
    return filePath;
  }

  void writeFile(RelatorioModel relatorio, String code) async {
    final file = File(await getFilePath(code));
    await file.writeAsString(json.encode(relatorio));
  }

  Future<void> setNewQuest(String code, int id, int tentativa) async {
    RelatorioModel fullRelatorio = await getFileContents(code);
    var aux = { "tentativas": tentativa, "id": id};
    Quests.fromJson(aux);
    fullRelatorio.quests?.add(Quests.fromJson(aux));
    writeFile(fullRelatorio, code);
  }
}
