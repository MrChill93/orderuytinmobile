// ignore_for_file: avoid_print

import 'dart:io';

void main() {
  // Replace "path/to/directory" with the actual path to the directory you want to rename files in
  print("Keo tha directory chua icons can doi ten vao day:");
  final String? originPath = stdin.readLineSync();
  final path = (originPath ?? "")
      .split("hcm23_demo_prj")
      .last
      .substring(1)
      .replaceAll("'", "");
  print(path);
  final directory = Directory(path);
  int fileCount = 0;

  directory.listSync().forEach((file) {
    if (file is File && file.path.endsWith(".svg")) {
      final fileName = file.path.split("/").last;
      final snakeCaseFileName = fileName
          .replaceAllMapped(
            RegExp(r'[^a-zA-Z0-9]+'),
            (_) => '_',
          )
          .replaceAllMapped(
            RegExp(r'(?<!^)([A-Z])'),
            (match) => '${match.group(0)}',
          )
          .toLowerCase();
      String newFilePath = "${file.parent.path}/$snakeCaseFileName";
      final int lastUnderscoreIndex = newFilePath.lastIndexOf("_");
      if (lastUnderscoreIndex > 0) {
        newFilePath = newFilePath.replaceRange(
            lastUnderscoreIndex, lastUnderscoreIndex + 1, ".");
        file.renameSync(newFilePath);
      }

      print("${file.path} -> $newFilePath");
      fileCount++;
    }
  });
  print("Renamed $fileCount files!!!");
}
