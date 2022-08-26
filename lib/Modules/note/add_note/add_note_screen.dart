import 'package:flutter/material.dart';
import 'package:note_bad/Modules/note/add_note/add_note_view_model.dart';
import 'package:note_bad/Resources/constant_strings.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key key}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddNoteViewModel>(
      create: (_) => AddNoteViewModel(),
      builder: (context, child) => _Body(),
      lazy: true,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: save,
            onPressed: () async {},
          ),
        ],
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
    var vm = context.watch<AddNoteViewModel>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: null,
            controller: vm.contentController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: whatIsOnYourMind,
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
    var vm = context.watch<AddNoteViewModel>();

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
                    hintText: noteTitle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
