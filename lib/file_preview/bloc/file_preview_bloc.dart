import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:convert_cert/cert_generator/certificate_generator.dart'
    as Generator;
import 'package:convert_cert/dart_file_settings/model/dart_file_type.dart';
import 'package:equatable/equatable.dart';

part 'file_preview_event.dart';
part 'file_preview_state.dart';

class FilePreviewBloc extends Bloc<FilePreviewEvent, FilePreviewState> {
  FilePreviewBloc() : super(FilePreviewNoPreview());

  List<File> files = [];
  String fileName = "";
  Generator.DartFileType? fileType;

  @override
  Stream<FilePreviewState> mapEventToState(
    FilePreviewEvent event,
  ) async* {
    if (event is FilePreviewSourcesUpdated) {
      files = event.files.map((e) => File(e)).toList();
      yield _updateGeneratedFile();
    } else if (event is FilePreviewSettingsFilled) {
      fileName = event.name;
      fileType = event.fileType.convert();
      yield _updateGeneratedFile();
    } else if (event is FilePreviewSettingsBlank) {
      fileName = "";
      fileType = null;

      yield FilePreviewNoPreview();
    }
  }

  FilePreviewState _updateGeneratedFile() {
    if (files.isNotEmpty && fileName.isNotEmpty && fileType != null) {
      final code = Generator.writeCertificatesToDartFile(
        files,
        fileType: fileType!,
        className: fileName,
      );
      return FilePreviewGenerated(code);
    } else {
      return FilePreviewNoPreview();
    }
  }
}

extension on DartFileType {
  Generator.DartFileType convert() => this == DartFileType.abstractClass
      ? Generator.DartFileType.abstractClass
      : Generator.DartFileType.topLevelFields;
}
