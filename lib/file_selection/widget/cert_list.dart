import 'dart:io';

import 'package:convert_cert/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
