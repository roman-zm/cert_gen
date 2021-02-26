import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  List<String> files = [];

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeFilesAddedEvent) {
      event.files.forEach((file) {
        if (!files.contains(file)) {
          files.add(file);
        }
      });

      yield HomeFilesSelectedState(files.toList(growable: false));
    } else if (event is HomeFileRemovedEvent) {
      final removed = files.remove(event.file);
      if (removed) {
        yield HomeFilesSelectedState(files.toList(growable: false));
      }
    }
  }
}
