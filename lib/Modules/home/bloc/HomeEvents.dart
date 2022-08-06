import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
class HomeEvent extends Equatable{
  @override
  List<Object> get props =>[];
}
class InitiateHome extends HomeEvent{}
class NoteSelected extends HomeEvent{
  final int index;

  NoteSelected({@required this.index});

  @override
  List<Object> get props => [index];
}
class NewNoteSelected extends HomeEvent{}
class MarkedNoteSelected extends HomeEvent{}
class DeleteNote extends HomeEvent{}