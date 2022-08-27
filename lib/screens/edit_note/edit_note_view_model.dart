import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_bad/Models/note.dart';
import 'package:note_bad/Services/notes_database.dart';
import 'package:note_bad/routes/router_names.dart';

class EditNoteViewModel extends ChangeNotifier {
  final int noteId;

  EditNoteViewModel({@required this.noteId});

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool _isLoading;

  bool get isLoading => _isLoading;

  void setLoadingState(value) {
    _isLoading = value;
    notifyListeners();
  }

  final _notesDatabase = NotesDatabase.instance;

  Note _selectedNote;

  Note get selectedNote => _selectedNote;

  Future<void> loadNoteAsync(int noteId) async {
    setLoadingState(true);
    try {
      _selectedNote = await _notesDatabase.readNote(noteId);
      if (_selectedNote != null) {
        titleController.text = _selectedNote.title;
        contentController.text = _selectedNote.description;
      }
    } on Exception {
      log('error loading note');
    }
    setLoadingState(false);
    notifyListeners();
  }

  Future<void> onUpdateNoteAction() async {
    setLoadingState(true);
    var _note = Note(
      id: noteId,
      title: titleController.text,
      description: contentController.text,
      createdDate: DateTime.now(),
    );
    var updatingNote = await _notesDatabase.update(_note);
    if(updatingNote != 1){
      //TODO add snack bar
      return;
    }
    Get.offNamedUntil(homeRoute, (route) => false);
    setLoadingState(false);
    notifyListeners();
  }
}
