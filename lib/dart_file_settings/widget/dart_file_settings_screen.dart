import 'package:flutter/material.dart';

import 'dart_file_settings.dart';

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
