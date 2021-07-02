import 'package:equatable/equatable.dart';
class HomeEvent extends Equatable{
  @override
  List<Object> get props =>[];
}
class NoteSelected extends HomeEvent{}
class NewNoteSelected extends HomeEvent{}
class MarkedNoteSelected extends HomeEvent{}
class DeleteNote extends HomeEvent{}