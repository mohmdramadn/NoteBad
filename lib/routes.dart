import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeBloc.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeStates.dart';
import 'package:note_bad/Modules/HomeModule/views/HomeScreen.dart';
import 'package:note_bad/Modules/NoteModule/views/NoteScreen.dart';
import 'package:note_bad/Resources/constant_strings.dart';

class Routes extends StatefulWidget {
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData.dark(),
      initialRoute: HomePage.pageId,
      routes: {
        HomePage.pageId: (context) => HomePage(),
        NotePage.pageId: (context) => NotePage()
      },
    );
  }
}
