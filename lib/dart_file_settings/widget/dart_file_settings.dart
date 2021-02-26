import 'package:flutter/material.dart';

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
