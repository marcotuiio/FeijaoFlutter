import 'dart:convert';
import 'dart:io';

createFile(Map<String, dynamic> content, String dir, String fileName) {
  File file = File(dir + "/" + fileName);
  file.createSync();
  file.writeAsStringSync(json.encode(content));
}