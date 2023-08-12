import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_bad/Resources/notes_card.dart';
import 'package:note_bad/Resources/constant_strings.dart';
import 'package:note_bad/screens/home/home_view_model.dart';
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
        onPressed: () =>
            context.read<HomeViewModel>().onAddNoteSelectedAction(),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      appBar: AppBar(
        title: Text(
          appTitle,
        ),
      ),
      body: vm.isLoading
          ? _LoadingWidget()
          : vm.notesList != null && vm.notesList.length != 0
              ? _NotesList()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        noNotes,
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                  ],
                ),
    );
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
          mainAxisAlignment: MainAxisAlignment.center,
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
            onTap: () =>
                context.read<HomeViewModel>().onNoteSelectedAction(index),
            child: NotesCard(
              index: index,
              note: vm.notesList[index],
            ),
          );
        });
  }
}
