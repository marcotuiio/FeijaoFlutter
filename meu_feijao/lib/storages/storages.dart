import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Storage {
  String? fileofInterest;
  Storage({required this.fileofInterest});
  bool fileexist = false;

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/$fileofInterest'); //tirar .json???
  }

  Future<bool> checkExist() async {
    try {
      final file = await localFile;
      fileexist = file.existsSync();
      return fileexist;
    } catch (e) {
      return fileexist = false;
    }
  }

  Future<File> nameJsonFile() async {
    final response = await localFile;
    return response;
  }
}

// class InternalData {
//   static Future<Map<String, dynamic>> getNameJson() async {
//     final response = await localPath;
//     final List<Game> games = gameFromJson(response.readAsStringSync());
//     return games;
//   }
// }