import 'package:note_bad/Models/note.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

List<SingleChildWidget> providers = [
  Provider<Note>(
    create: (_) => Note(),
  ),
];
