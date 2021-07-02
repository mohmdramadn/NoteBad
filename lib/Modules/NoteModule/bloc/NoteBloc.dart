import 'package:bloc/bloc.dart';
import 'package:note_bad/Modules/NoteModule/bloc/NoteEvent.dart';
import 'package:note_bad/Modules/NoteModule/bloc/NoteState.dart';
class NoteBloc extends Bloc<NoteEvent,NoteState>{
  NoteBloc() : super(NoteState());

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async*{
    if(event is CreateNewNote){
      yield  CreateNewNoteState();
    }else if (event is SaveEditsNote){
      yield SaveEditsNoteState();
    }else if (event is DismissNewNote){
      yield DismissNewNoteState();
    }else if (event is EditNote){
      yield EditNoteState();
    }else if (event is DeleteNote){
      yield DeleteNoteState();
    }else if (event is SaveEditsNote){
      yield SaveEditsNoteState();
    }else if (event is SaveNewNote){
      yield SaveNewNoteState();
    }
  }
}