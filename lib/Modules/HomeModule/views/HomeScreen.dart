import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeBloc.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeEvents.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeStates.dart';
import 'package:note_bad/Modules/NoteModule/bloc/NoteBloc.dart';
import 'package:note_bad/Modules/NoteModule/bloc/NoteEvent.dart';
import 'package:note_bad/Modules/NoteModule/views/NoteScreen.dart';
import 'package:note_bad/Resources/NotesCard.dart';
import 'package:note_bad/Resources/constant_strings.dart';
import 'package:note_bad/Services/NoteModel.dart';
import 'package:note_bad/Services/NotesDatabase.dart';

class HomePage extends StatefulWidget {
  static final String pageId = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes;

  @override
  void initState() {
    loadNotes();
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is InitialState) {
        //notes = state.notes;
      } else if (state is NewNoteSelectedState) {
        BlocProvider.of<NoteBloc>(context).add(CreateNewNote());
        Future.delayed(Duration.zero, () {
          Navigator.pushNamed(context, NotePage.pageId);
        });
      } else if (state is NoteSelectedState) {
//        Future.delayed(Duration.zero, () {
//          Navigator.of(context).push(
//            MaterialPageRoute(
//                builder: (context) => NotePage(
//                      noteId: state.index,
//                    )),
//          );
//        });
      } else if (state is DeleteNoteState) {
      } else if (state is MarkedNoteSelectedState) {
      } else {
        print(state);
      }

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              BlocProvider.of<HomeBloc>(context).add(NewNoteSelected());
            });
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.grey,
        ),
        appBar: AppBar(
          title: Text(
            appTitle,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                tooltip: 'Refresh',
                onPressed: () {
                  loadNotes();
                })
          ],
        ),
        body: isLoading
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text(
                        'Loading Home',
                      ),
                    ],
                  ),
                ),
              )
            : notes != null
                ? StaggeredGridView.countBuilder(
                    padding: EdgeInsets.all(8.0),
                    crossAxisCount: 4,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    itemCount: notes.length,
                    staggeredTileBuilder: (index) =>
                        StaggeredTile.count(2, index.isEven ? 2 : 1.5),
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            BlocProvider.of<HomeBloc>(context)
                                .add(NoteSelected(index: note.id));
                            Future.delayed(Duration.zero, () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => NotePage(
                                          noteId: note.id,
                                        )),
                              );
                            });
                            BlocProvider.of<NoteBloc>(context)
                                .add(EditNote(note.id));
                            loadNotes();
                          });
                        },
                        child: NotesCard(
                          index: index,
                          note: note,
                        ),
                      );
                    })
                : Center(
                    child: Text(
                      'No Notes Yet!',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
      );
    });
  }

  Future loadNotes() async {
    setState(() => isLoading = true);
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
//    NotesDatabase.instance.close();
    super.dispose();
  }
}
