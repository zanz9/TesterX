import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:testerx/models/txjson.dart';

Future<List<Object>?> getFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['bin', 'TX'],
  );
  if (result == null) {
    return null;
  }
  var content = await File(result.files.single.path ?? '').readAsString();
  TxJson txJson = TxJson.fromJson(jsonDecode(content));
  String quizTitle = result.files.first.name;
  return [txJson, quizTitle];
}
