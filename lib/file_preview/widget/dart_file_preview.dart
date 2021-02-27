import 'package:convert_cert/dart_file_settings/bloc/dart_file_bloc.dart';
import 'package:convert_cert/file_preview/bloc/file_preview_bloc.dart';
import 'package:convert_cert/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_highlight/flutter_highlight.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_highlight/themes/dark.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_highlight/themes/default.dart';

class DartFilePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => buildBloc(context),
      child: _DartFilePreview(),
    );
  }

  FilePreviewBloc buildBloc(BuildContext context) {
    final bloc = FilePreviewBloc();
    bloc.add(FilePreviewSourcesUpdated(context.read<HomeBloc>().state.files));
    final dartFileState = context.read<DartFileBloc>().state;
    bloc.add(
      dartFileState.filled
          ? FilePreviewSettingsFilled(
              dartFileState.name, dartFileState.fileType)
          : FilePreviewSettingsBlank(),
    );

    return bloc;
  }
}

class _DartFilePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(listener: _handleHomeState),
        BlocListener<DartFileBloc, DartFileState>(
            listener: _handleDartFileState),
      ],
      child: CodeView(),
    );
  }

  void _handleHomeState(BuildContext context, HomeState state) => context
      .read<FilePreviewBloc>()
      .add(FilePreviewSourcesUpdated(state.files));

  void _handleDartFileState(BuildContext context, DartFileState state) =>
      context.read<FilePreviewBloc>().add(
            state.filled
                ? FilePreviewSettingsFilled(state.name, state.fileType)
                : FilePreviewSettingsBlank(),
          );
}

class CodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilePreviewBloc, FilePreviewState>(
      builder: (context, state) => state is FilePreviewGenerated
          ? SingleChildScrollView(
              child: HighlightView(
                state.code,
                language: 'dart',
                theme: Theme.of(context).brightness == Brightness.dark
                    ? darkTheme
                    : defaultTheme,
              ),
              scrollDirection: Axis.horizontal,
            )
          : Container(),
    );
  }
}
