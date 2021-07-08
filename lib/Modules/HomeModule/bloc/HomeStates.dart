import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:note_bad/Services/NoteModel.dart';
class HomeState extends Equatable{
  @override
  List<Object> get props => [];

}
class InitialState extends HomeState{
  final List<Note> notes;
  InitialState({@required this.notes});
  @override
  List<Object> get props=>[notes];
}
class NoteSelectedState extends HomeState{
  final int index;

  NoteSelectedState({@required this.index});

  @override
  List<Object> get props => [index];
}
class NewNoteSelectedState extends HomeState{}
class DeleteNoteState extends HomeState{}
class MarkedNoteSelectedState extends HomeState{}