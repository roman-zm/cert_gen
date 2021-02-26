import 'dart:io';

import 'package:path/path.dart';

enum DartFileType { abstractClass, topLevelFields }

String writeCertificatesToDartFile(
  List<File> certificateList, {
  DartFileType fileType = DartFileType.abstractClass,
  String className = 'Certificates',
}) {
  final buffer = StringBuffer();

  if (fileType == DartFileType.abstractClass) {
    buffer.writeln('abstract class $className {');
  }

  for (final file in certificateList) {
    if (fileType == DartFileType.abstractClass) {
      buffer.write('  ');
    }

    writeCertificate(file, buffer);
  }

  if (fileType == DartFileType.abstractClass) {
    buffer.writeln('}');
  }

  return buffer.toString();
}

void writeCertificate(File certFile, StringBuffer buffer) {
  if (!certFile.existsSync()) {
    exitCode = 1;

    throw Exception('File certificate ${certFile.path} not found.');
  }

  var fileNameWithoutExt = basenameWithoutExtension(certFile.path);

  var cert = certFile.readAsBytesSync();
  var res =
      "static const List<int> $fileNameWithoutExt = <int>[${cert.join(', ')}];";

  buffer.writeln(res);
}
