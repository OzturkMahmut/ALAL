import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:async';


class WordStorage {
  //https://docs.flutter.dev/cookbook/persistence/reading-writing-files
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/AddedWords.txt');
  }

  Future<List<String>> readWords() async {
    try {
      final file = await _localFile;
      Future<List<String>> lines = file
          .openRead()
          .transform(utf8.decoder) // Decode bytes to UTF-8.
          .transform(const LineSplitter()).toList(); //// Convert stream to individual lines.
          

      // Read the file
      //final contents = await file.readAsString();
      
      return lines;
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  Future<File> writeWord(String newWord) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$newWord\n',mode: FileMode.append);
  }
}