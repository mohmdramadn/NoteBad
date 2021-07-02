import 'package:bloc/bloc.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeEvents.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeStates.dart';
class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc() : super(HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if(event is NoteSelected){
      yield NoteSelectedState();
    }else if(event is DeleteNote){
      yield DeleteNoteState();
    }else if (event is MarkedNoteSelected){
      yield MarkedNoteSelectedState();
    }else if (event is NewNoteSelected){
      yield NewNoteSelectedState();
    }
  }
}