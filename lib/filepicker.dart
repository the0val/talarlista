import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'dart:convert';
import 'model.dart';
import 'speaker.dart';

class Filepicker {
  final SpeakersQueue model;

  Filepicker(this.model);

  void show() {
    Future<FilePickerResult?> res = FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
    handleResult(res);
  }

  void handleResult(Future<FilePickerResult?> res) async {
    FilePickerResult? result = await res;
    if (result != null) {
      File file = File(result.files.single.path!);
      var data = await file
          .openRead()
          .transform(utf8.decoder)
          .transform(const CsvToListConverter(
              fieldDelimiter: ';', shouldParseNumbers: false))
          .toList();

      var speakerData = [
        for (List<dynamic> row in data)
          switch (row.length) {
            1 => Speaker(row[0]),
            2 => Speaker(row[0], row[1]),
            3 => Speaker(row[0], row[1], row[2]),
            4 => Speaker(row[0], row[1], row[2], row[3]),
            _ => throw FormatException('Invalid format: ${row.toString()}'),
          }
      ];
      model.speakerData = speakerData;
    }
  }
}
