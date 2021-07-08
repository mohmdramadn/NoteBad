import 'package:bloc/bloc.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeEvents.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeStates.dart';
import 'package:note_bad/Services/NoteModel.dart';
import 'package:note_bad/Services/NotesDatabase.dart';
class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc() : super(HomeState());
  List<Note> notes=[];
  Note note;
  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if(event is InitiateHome){
      notes = await NotesDatabase.instance.readAllNotes();
      yield InitialState(notes: notes);
    } else if(event is NoteSelected){
      note = await NotesDatabase.instance.readNote(event.index);
      yield NoteSelectedState(index: event.index);
    }else if(event is DeleteNote){
      yield DeleteNoteState();
    }else if (event is MarkedNoteSelected){
      yield MarkedNoteSelectedState();
    }else if (event is NewNoteSelected){
      yield NewNoteSelectedState();
    }
  }
}