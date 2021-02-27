import 'package:convert_cert/dart_file_settings/bloc/dart_file_bloc.dart';
import 'package:convert_cert/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => HomeBloc(), child: child),
          BlocProvider(create: (_) => DartFileBloc(), child: child)
        ],
        child: child,
      );
}
