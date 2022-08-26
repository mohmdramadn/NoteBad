import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:note_bad/Models/note.dart';
import 'package:note_bad/Services/notes_database.dart';

class EditNoteViewModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool _isLoading;
  bool get isLoading => _isLoading;
  void setLoadingState(value) {
    _isLoading = value;
    notifyListeners();
  }

  Note _selectedNote;
  Note get selectedNote => _selectedNote;

  Future<void> loadNoteAsync(int noteId) async {
    setLoadingState(true);
    try {
      _selectedNote = await NotesDatabase.instance.readNote(noteId);
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

// final note = Note(
//   id: widget.noteId,
//   title: _titleController.text,
//   description: _contentController.text,
//   createdDate: DateTime.now(),
// );
// await NotesDatabase.instance.update(note);
}
