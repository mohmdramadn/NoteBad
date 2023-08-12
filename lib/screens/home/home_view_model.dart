import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_bad/Models/note.dart';
import 'package:note_bad/Services/notes_database.dart';
import 'package:note_bad/routes/router_names.dart';

class HomeViewModel extends ChangeNotifier {
  Future<void> getNotesAsync() async {
    setLoadingState(true);
    _notesList = await _notesDatabase.readAllNotes();
    setLoadingState(false);
    notifyListeners();
  }

  final _notesDatabase = NotesDatabase.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Note> _notesList;
  List<Note> get notesList => _notesList;

  Future<void> onNoteSelectedAction(int index) async {
    setLoadingState(true);
    var noteId = _notesList[index].id;
    Get.toNamed(editNoteRoute, arguments: noteId);
    setLoadingState(false);
    notifyListeners();
  }

  Future<void> onAddNoteSelectedAction() async {
    Get.toNamed(addNoteRoute);
    notifyListeners();
  }
}
