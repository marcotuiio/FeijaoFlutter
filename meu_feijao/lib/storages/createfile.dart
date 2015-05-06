import 'dart:convert';
import 'dart:io';

bool createFile(Map<String, dynamic> content, Directory dir, String fileName) {
  File file = File(dir.path + "/" + fileName);
  bool namefileExists = true;
  file.createSync();
  file.writeAsStringSync(json.encode(content));
  return namefileExists;
}
