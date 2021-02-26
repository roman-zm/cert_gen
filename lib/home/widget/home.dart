import 'dart:io';

import 'package:convert_cert/home/bloc/bloc/home_bloc.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 650) {
          return MobileHomeScreen();
        } else {
          return DesktopHomeScreen();
        }
      },
    );
  }
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
  Widget build(BuildContext context) {
    return SelectFilesScreen();
  }
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

class DartFileSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _navigateBack(constraints, context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Настроить файл'),
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: DartFileSettings(),
          ),
        );
      },
    );
  }

  void _navigateBack(BoxConstraints constraints, BuildContext context) {
    if (constraints.maxWidth >= 650) {
      Navigator.maybePop(context);
    }
  }
}

class DartFileSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Имя',
            hintText: 'Certificates',
            border: OutlineInputBorder(),
          ),
        ),
        CheckboxListTile(
          value: true,
          onChanged: (value) {},
          title: Text("Абстрактный класс"),
        )
      ],
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
        HomeFilesAddedEvent(files.map((e) => e.path).toList(growable: false)));
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

class CertList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final List<File> files =
            state.files.map((e) => File(e)).toList(growable: false);

        return ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) => FileTile(files[index]),
        );
      },
    );
  }
}

class FileTile extends StatelessWidget {
  final File file;

  const FileTile(this.file, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(file.absolute.path.split('/').last),
      leading: Icon(Icons.file_present),
      trailing: IconButton(
        splashRadius: 20,
        icon: Icon(Icons.remove),
        onPressed: () {
          context.read<HomeBloc>().add(HomeFileRemovedEvent(file.path));
        },
      ),
    );
  }
}
