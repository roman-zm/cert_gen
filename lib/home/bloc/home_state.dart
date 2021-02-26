part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final List<String> files;

  HomeState(this.files);

  @override
  List<Object> get props => [files.hashCode];
}

class HomeInitial extends HomeState {
  HomeInitial() : super([]);
}

class HomeFilesSelectedState extends HomeState {
  HomeFilesSelectedState(List<String> files) : super(files);
}
