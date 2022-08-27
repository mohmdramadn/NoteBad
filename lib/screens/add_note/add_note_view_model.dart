import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_bad/Models/note.dart';
import 'package:note_bad/Services/notes_database.dart';
import 'package:note_bad/routes/router_names.dart';

class AddNoteViewModel extends ChangeNotifier {

  final _notesDatabase = NotesDatabase.instance;

  Note _note;
  Note get note => _note;

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> onSaveNoteSelectedAction() async {
    if(titleController.text == "" || contentController.text == ""){
      //TODO add snack bar
      return;
    }
    setLoadingState(true);
    _note = Note(
      title: titleController.text,
      description: contentController.text,
      createdDate: DateTime.now(),
    );
    var addNote = await _notesDatabase.create(_note);

    if(addNote == null){
      //TODO add snack bar
      return;
    }
    Get.offNamedUntil(homeRoute, (route) => false);
    setLoadingState(false);
    notifyListeners();
  }
}
