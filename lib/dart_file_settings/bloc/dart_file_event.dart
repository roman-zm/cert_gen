part of 'dart_file_bloc.dart';

abstract class DartFileEvent extends Equatable {
  const DartFileEvent();

  @override
  List<Object> get props => [];
}

class DartFileNameChanged extends DartFileEvent {
  final String name;

  DartFileNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class DartFileTypeChanged extends DartFileEvent {
  final DartFileType type;

  DartFileTypeChanged(this.type);

  @override
  List<Object> get props => [type];
}
