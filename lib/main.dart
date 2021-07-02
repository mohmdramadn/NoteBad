import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeBloc.dart';
import 'package:note_bad/Modules/HomeModule/views/HomeScreen.dart';
import 'package:note_bad/Modules/NoteModule/bloc/NoteBloc.dart';
import 'package:note_bad/Modules/NoteModule/views/NoteScreen.dart';
import 'package:note_bad/routes.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(), child: HomePage()),
      BlocProvider<NoteBloc>(
          create: (context) => NoteBloc(), child: NotePage()),
    ],
    child: Routes(),
  ));
}
