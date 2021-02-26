import 'package:convert_cert/dart_file_settings/widget/dart_file_settings_screen.dart';
import 'package:convert_cert/home/bloc/home_bloc.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cert_list.dart';

class SelectFilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Сертификаты"),
          actions: [
            SelectFilesDoneButton(),
          ],
        ),
        body: CertList(),
        floatingActionButton: AddCertFloatingActionButton(),
      );
}

class SelectFilesDoneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(Icons.done),
          onPressed: state.files.isNotEmpty ? () => _done(context) : null,
        );
      },
    );
  }

  _done(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DartFileSettingsScreen(),
      ),
    );
  }
}

class AddCertFloatingActionButton extends StatelessWidget
    with AddCertificateMixin {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => selectCertificate(context),
      child: Icon(Icons.add),
    );
  }
}

mixin AddCertificateMixin {
  selectCertificate(BuildContext context) async {
    final typeGroup = XTypeGroup(
      label: 'certificates',
      extensions: ['cer'],
    );
    final files = await openFiles(acceptedTypeGroups: [typeGroup]);
    context.read<HomeBloc>().add(
          HomeFilesAddedEvent(files.map((e) => e.path).toList(growable: false)),
        );
  }
}
