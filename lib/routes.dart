// import 'package:flutter/material.dart';
// import 'package:note_bad/screens/home/home_screen.dart';
// import 'package:note_bad/screens/note/note_screen.dart';
// import 'package:note_bad/Resources/constant_strings.dart';
// import 'package:note_bad/Services/notes_database.dart';
//
// class Routes extends StatefulWidget {
//   @override
//   _RoutesState createState() => _RoutesState();
// }
//
// class _RoutesState extends State<Routes> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: appTitle,
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
//       initialRoute: HomePage.pageId,
//       routes: {
//         HomePage.pageId: (context) => HomePage(),
//         NotePage.pageId: (context) => NotePage()
//       },
//     );
//   }
//   @override
//   void dispose() {
//     NotesDatabase.instance.close();
//     super.dispose();
//   }
// }
