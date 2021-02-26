part of 'dart_file_bloc.dart';

class DartFileState extends Equatable {
  final String name;
  final DartFileType fileType;

  const DartFileState(this.name, this.fileType);

  bool get filled => name.isNotEmpty;

  DartFileState copyWith({
    String? name,
    DartFileType? fileType,
  }) =>
      DartFileState(
        name ?? this.name,
        fileType ?? this.fileType,
      );

  @override
  List<Object> get props => [name, fileType];
}
