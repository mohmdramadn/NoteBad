import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_bad/Modules/home/home_view_model.dart';
import 'package:note_bad/Resources/notes_card.dart';
import 'package:note_bad/Resources/constant_strings.dart';
import 'package:note_bad/Services/notes_database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      builder: (context, child) => _Body(),
      lazy: true,
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    Future.microtask(() => context.read<HomeViewModel>().getNotesAsync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<HomeViewModel>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
            tooltip: refresh,
            onPressed: () {},
          ),
        ],
      ),
      body: vm.isLoading
          ? _LoadingWidget()
          : vm.notesList != null
              ? _NotesList()
              : Center(
                  child: Text(
                    noNotes,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
    );
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircularProgressIndicator(),
            Text(loadingNotes),
          ],
        ),
      ),
    );
  }
}

class _NotesList extends StatelessWidget {
  const _NotesList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<HomeViewModel>();

    return StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8.0),
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemCount: vm.notesList.length,
        staggeredTileBuilder: (index) =>
            StaggeredTile.count(2, index.isEven ? 2 : 1.5),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // setState(() {
              //   BlocProvider.of<HomeBloc>(context)
              //       .add(NoteSelected(index: note.id));
              //   Future.delayed(Duration.zero, () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //           builder: (context) => NotePage(
              //                 noteId: note.id,
              //               )),
              //     );
              //   });
              //   BlocProvider.of<NoteBloc>(context)
              //       .add(EditNote(note.id));
              //   loadNotes();
              // });
            },
            child: NotesCard(
              index: index,
              note: vm.notesList[index],
            ),
          );
        });
  }
}
