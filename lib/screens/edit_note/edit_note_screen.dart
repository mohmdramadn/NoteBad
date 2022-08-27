import 'package:flutter/material.dart';
import 'package:note_bad/Resources/constant_strings.dart';
import 'package:note_bad/screens/edit_note/edit_note_view_model.dart';
import 'package:provider/provider.dart';

class EditNotePage extends StatefulWidget {
  final int noteId;

  const EditNotePage({Key key, @required this.noteId}) : super(key: key);

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditNoteViewModel>(
      create: (_) => EditNoteViewModel(noteId: widget.noteId),
      builder: (context, child) => _Body(noteId: widget.noteId),
      lazy: true,
    );
  }
}

class _Body extends StatefulWidget {
  final int noteId;

  const _Body({Key key, @required this.noteId}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    Future.microtask(
        () => context.read<EditNoteViewModel>().loadNoteAsync(widget.noteId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: Icon(Icons.save_alt),
        color: Colors.blue,
        tooltip: 'Update',
        onPressed: () => context.read<EditNoteViewModel>().onUpdateNoteAction(),
      ),
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _NoteTitle(),
            _NoteContent(),
          ],
        ),
      ),
    );
  }
}

class _NoteContent extends StatelessWidget {
  const _NoteContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<EditNoteViewModel>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.done,
            maxLines: null,
            controller: vm.contentController,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

class _NoteTitle extends StatelessWidget {
  const _NoteTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<EditNoteViewModel>();

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: vm.titleController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
