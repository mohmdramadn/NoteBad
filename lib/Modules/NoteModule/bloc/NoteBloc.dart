import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:note_bad/Modules/NoteModule/bloc/NoteEvent.dart';
import 'package:note_bad/Modules/NoteModule/bloc/NoteState.dart';
import 'package:note_bad/Services/NoteModel.dart';
import 'package:note_bad/Services/NotesDatabase.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteState());
  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    print(event);
    if (event is CreateNewNote) {
      yield CreateNewNoteState();
    } else if (event is SaveEditsNote) {
      yield SaveEditsNoteState();
    } else if (event is DismissNewNote) {
      yield DismissNewNoteState();
    } else if (event is EditNote) {
      yield EditNoteState(event.noteIndex);
    } else if (event is DeleteCurrentNote) {
      await NotesDatabase.instance.delete(event.noteIndex);
      yield DeleteNoteState();
    } else if (event is SaveEditsNote) {
      final notes = Note(
        id: event.id,
        title: event.noteTitle,
        description: event.noteBody,
        createdDate: event.time,
      );
      await NotesDatabase.instance.update(notes);
      yield SaveEditsNoteState();
    } else if (event is SaveNewNote) {
      final note =
      Note(
          title: event.noteTitle,
          description: event.noteBody,
          createdDate: DateTime.now()
      );
      await NotesDatabase.instance.create(note);
      yield SaveNewNoteState();
    }
  }
}
