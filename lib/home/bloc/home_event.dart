part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeFilesAddedEvent extends HomeEvent {
  final List<String> files;

  HomeFilesAddedEvent(this.files);

  @override
  List<Object> get props => [files.toString()];
}

class HomeFileRemovedEvent extends HomeEvent {
  final String file;

  HomeFileRemovedEvent(this.file);

  @override
  List<Object> get props => [file];
}
