import 'package:convert_cert/dart_file_settings/widget/dart_file_settings.dart';
import 'package:convert_cert/file_selection/widget/cert_list.dart';
import 'package:convert_cert/file_selection/widget/select_files_screen.dart';
import 'package:convert_cert/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth < 650
            ? MobileHomeScreen()
            : DesktopHomeScreen(),
      );
}

class DesktopHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Генератор'),
        centerTitle: false,
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: CertList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddCertButton(),
                ),
              ],
            ),
          ),
          VerticalDivider(width: 8),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            child: DartFileSettings(),
          )),
        ],
      ),
    );
  }
}

class MobileHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SelectFilesScreen();
}

class OpenFilesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SelectFilesScreen(),
          ),
        );
      },
      child: Text("Выбрать файлы"),
    );
  }
}

class SelectedFilesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final listLength = state.files.length > 3 ? 3 : state.files.length;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < listLength; i++) Text(state.files[i]),
            if (state.files.length > 3)
              Text("и ещё ${state.files.length - listLength}"),
            if (state.files.isEmpty) Text("Пусто"),
          ],
        );
      },
    );
  }
}

class AddCertButton extends StatelessWidget with AddCertificateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => selectCertificate(context),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('Выбрать сертификат'.toUpperCase()),
        ),
      ),
    );
  }
}
