import 'package:equatable/equatable.dart';
class NoteEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class CreateNewNote extends NoteEvent{}
class SaveNewNote extends NoteEvent{}
class DismissNewNote extends NoteEvent{}
class EditNote extends NoteEvent{}
class DeleteNote extends NoteEvent{}
class SaveEditsNote extends NoteEvent{}
