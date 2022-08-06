import 'package:flutter/material.dart';
import 'package:note_bad/Modules/home/home_screen.dart';
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
          builder: (context) => NotePage(), settings: settings);
    default:
      return MaterialPageRoute(builder: (context) => SplashScreen());
  }
}