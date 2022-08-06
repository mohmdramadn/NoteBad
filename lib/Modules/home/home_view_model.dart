import 'package:flutter/cupertino.dart';
import 'package:note_bad/Models/note.dart';
import 'package:note_bad/Services/notes_database.dart';

class HomeViewModel extends ChangeNotifier {
  Future<void> getNotesAsync() async {
    setLoadingState(true);
    _notesList = await NotesDatabase.instance.readAllNotes();
    setLoadingState(false);
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Note> _notesList;
  List<Note> get notesList => _notesList;
}
