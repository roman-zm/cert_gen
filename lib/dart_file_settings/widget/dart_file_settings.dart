import 'package:convert_cert/dart_file_settings/bloc/dart_file_bloc.dart';
import 'package:convert_cert/dart_file_settings/model/dart_file_type.dart';
import 'package:convert_cert/file_preview/widget/dart_file_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DartFileSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FileNameInput(),
        FileTypeCheckBox(),
        Flexible(
          child: SingleChildScrollView(
            child: DartFilePreview(),
          ),
        ),
      ],
    );
  }
}

class FileNameInput extends StatefulWidget {
  @override
  _FileNameInputState createState() => _FileNameInputState();
}

class _FileNameInputState extends State<FileNameInput> {
  final controller = TextEditingController();

  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DartFileBloc, DartFileState>(
      builder: (context, state) {
        if (!initialized) {
          controller.text = state.name;
          initialized = true;
        }

        return TextField(
          decoration: InputDecoration(
            labelText: 'Имя',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) =>
              context.read<DartFileBloc>().add(DartFileNameChanged(value)),
          controller: controller,
        );
      },
    );
  }
}

class FileTypeCheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DartFileBloc, DartFileState>(
      builder: (context, state) => CheckboxListTile(
        title: Text('Абстрактный класс'),
        value: state.fileType == DartFileType.abstractClass,
        onChanged: (value) {
          if (value == null) return;

          context.read<DartFileBloc>().add(
                DartFileTypeChanged(
                  value
                      ? DartFileType.abstractClass
                      : DartFileType.topLevelFields,
                ),
              );
        },
      ),
    );
  }
}
