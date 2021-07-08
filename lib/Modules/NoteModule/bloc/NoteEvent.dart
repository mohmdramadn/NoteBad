import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NoteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateNewNote extends NoteEvent {

}

class SaveNewNote extends NoteEvent {
  final String noteTitle;
  final String noteBody;
  final String time;

  SaveNewNote(@required this.noteTitle, @required this.noteBody,@required this.time);

  @override
  List<Object> get props => [noteTitle, noteBody];
}

class DismissNewNote extends NoteEvent {}

class EditNote extends NoteEvent {
  final int noteIndex;

  EditNote(@required this.noteIndex);

  @override
  List<Object> get props => [noteIndex];
}

class DeleteCurrentNote extends NoteEvent {
  final int noteIndex;

  DeleteCurrentNote(@required this.noteIndex);

  @override
  List<Object> get props => [noteIndex];
}

class SaveEditsNote extends NoteEvent {}
