import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:convert_cert/dart_file_settings/model/dart_file_type.dart';
import 'package:equatable/equatable.dart';

part 'dart_file_event.dart';
part 'dart_file_state.dart';

class DartFileBloc extends Bloc<DartFileEvent, DartFileState> {
  DartFileBloc()
      : super(DartFileState('Certificate', DartFileType.abstractClass));

  @override
  Stream<DartFileState> mapEventToState(
    DartFileEvent event,
  ) async* {
    if (event is DartFileNameChanged) {
      yield state.copyWith(name: event.name);
    } else if (event is DartFileTypeChanged) {
      yield state.copyWith(fileType: event.type);
    }
  }
}
