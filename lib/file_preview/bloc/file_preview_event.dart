part of 'file_preview_bloc.dart';

abstract class FilePreviewEvent extends Equatable {
  const FilePreviewEvent();

  @override
  List<Object> get props => [];
}

class FilePreviewSourcesUpdated extends FilePreviewEvent {
  final List<String> files;
  FilePreviewSourcesUpdated(this.files);

  @override
  List<Object> get props => [files];
}

class FilePreviewSettingsFilled extends FilePreviewEvent {
  final String name;
  final DartFileType fileType;

  FilePreviewSettingsFilled(this.name, this.fileType);

  @override
  List<Object> get props => [name, fileType];
}

class FilePreviewSettingsBlank extends FilePreviewEvent {}
