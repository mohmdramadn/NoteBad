import 'package:equatable/equatable.dart';
class NoteState extends Equatable{
  @override
  List<Object> get props => [];
}
class CreateNewNoteState extends NoteState{}
class SaveNewNoteState extends NoteState{}
class DismissNewNoteState extends NoteState{}
class EditNoteState extends NoteState{}
class DeleteNoteState extends NoteState{}
class SaveEditsNoteState extends NoteState{}