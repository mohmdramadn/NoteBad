import 'package:flutter/material.dart';
import 'package:note_bad/routes/router_names.dart';
import 'package:note_bad/screens/add_note/add_note_screen.dart';
import 'package:note_bad/screens/edit_note/edit_note_screen.dart';
import 'package:note_bad/screens/home/home_screen.dart';
import 'package:note_bad/screens/splash/splash_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return MaterialPageRoute(
          builder: (context) => HomePage(), settings: settings);

    case addNoteRoute:
      return MaterialPageRoute(
          builder: (context) => AddNotePage(),
          settings: settings);

    case editNoteRoute:
      return MaterialPageRoute(
          builder: (context) => EditNotePage(noteId: settings.arguments),
          settings: settings);
    default:
      return MaterialPageRoute(builder: (context) => SplashScreen());
  }
}
