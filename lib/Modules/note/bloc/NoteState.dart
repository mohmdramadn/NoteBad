import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
class NoteState extends Equatable{
  @override
  List<Object> get props => [];
}
class CreateNewNoteState extends NoteState{}
class SaveNewNoteState extends NoteState{}
class DismissNewNoteState extends NoteState{}
class EditNoteState extends NoteState{
  final int noteIndex;

  EditNoteState(@required this.noteIndex);

  @override
  List<Object> get props => [noteIndex];
}
class DeleteNoteState extends NoteState{}
class SaveEditsNoteState extends NoteState{}