import 'package:flutter/material.dart';
import 'package:note_bad/Modules/home/home_screen.dart';
import 'package:note_bad/Modules/note/add_note/add_note_screen.dart';
import 'package:note_bad/Modules/note/edit_note/edit_note_screen.dart';
import 'package:note_bad/Modules/note/note_screen.dart';
import 'package:note_bad/Modules/splash/splash_screen.dart';
import 'package:note_bad/routes/router_names.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return MaterialPageRoute(
          builder: (context) => HomePage(), settings: settings);

    case addNoteRoute:
      return MaterialPageRoute(
          builder: (context) => AddNotePage(), settings: settings);

    case editNoteRoute:
      return MaterialPageRoute(
          builder: (context) => EditNotePage(noteId: settings.arguments),
          settings: settings);
    default:
      return MaterialPageRoute(builder: (context) => SplashScreen());
  }
}
