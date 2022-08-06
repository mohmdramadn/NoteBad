import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_bad/Models/note.dart';
import 'package:note_bad/Modules/home/bloc/HomeBloc.dart';
import 'package:note_bad/Modules/home/bloc/HomeEvents.dart';
import 'package:note_bad/Modules/note/bloc/NoteBloc.dart';
import 'package:note_bad/Modules/note/bloc/NoteEvent.dart';
import 'package:note_bad/Modules/note/bloc/NoteState.dart';
import 'package:note_bad/Services/notes_database.dart';

class NotePage extends StatefulWidget {
  static final String pageId = 'note';
  final int noteId;

  const NotePage({Key key, this.noteId}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String _date = '';
  bool isLoading = false;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  Note notes;

  @override
  void initState() {
    super.initState();
    loadData(widget.noteId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
        builder: (BuildContext context, state) {
      return Builder(
        builder: (BuildContext context) {
          if (state is CreateNewNoteState) {
            return _buildNewNoteWidget();
          } else if (state is EditNoteState) {
            return isLoading
                ? Scaffold(
                    appBar: AppBar(
                      title: Text('Edit Note'),
                    ),
                    body: Center(
                        child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Loading Home ...'),
                      ],
                    )),
                  )
                : _buildExistingNoteWidget();
          }
//          else if(state is SaveNewNoteState){
//            Navigator.pop(context);
//            return Container();
//          }
          else {
            return Container();
          }
        },
      );
    });
  }

  Widget _buildNewNoteWidget() {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: 'Save',
            onPressed: () async {
              BlocProvider.of<HomeBloc>(context).add(InitiateHome());
              BlocProvider.of<NoteBloc>(context).add(
                SaveNewNote(
                  _titleController.text,
                  _contentController.text,
                  _date,
                ),
              );
              Navigator.pop(context);
              // await Navigator.pushNamedAndRemoveUntil(
              //     context, HomePage.pageId, (r) => false);
              // setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Note Title'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: null,
                    controller: _contentController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What\'s on your mind?',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExistingNoteWidget() {
    _titleController.text = notes.title;
    _contentController.text = notes.description;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt),
            tooltip: 'Update',
            onPressed: () async {
              BlocProvider.of<NoteBloc>(context).add(
                SaveEditsNote(
                  widget.noteId,
                  _titleController.text,
                  _contentController.text,
                  DateTime.now(),
                ),
              );
              final note = Note(
                id: widget.noteId,
                title: _titleController.text,
                description: _contentController.text,
                createdDate: DateTime.now(),
              );
              await NotesDatabase.instance.update(note);
              Navigator.pop(context);
              // await Navigator.pushNamedAndRemoveUntil(
              //     context, HomePage.pageId, (r) => false);
              // setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    //initialValue: notes.description,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: null,
                    controller: _contentController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future loadData(int index) async {
    if (index != null) {
      setState(() => isLoading = true);
      this.notes = await NotesDatabase.instance.readNote(index);
      setState(() => isLoading = false);
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to delete currrent note?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                BlocProvider.of<HomeBloc>(context).add(InitiateHome());
                BlocProvider.of<NoteBloc>(context)
                    .add(DeleteCurrentNote(notes.id));
                Navigator.pop(context);
                // await Navigator.pushNamedAndRemoveUntil(
                //     context, HomePage.pageId, (r) => false);
                // setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}
