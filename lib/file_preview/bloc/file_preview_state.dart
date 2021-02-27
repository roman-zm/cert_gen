part of 'file_preview_bloc.dart';

abstract class FilePreviewState extends Equatable {
  const FilePreviewState();

  @override
  List<Object> get props => [];
}

class FilePreviewNoPreview extends FilePreviewState {}

class FilePreviewGenerated extends FilePreviewState {
  final String code;

  FilePreviewGenerated(this.code);

  @override
  List<Object> get props => [code];
}
