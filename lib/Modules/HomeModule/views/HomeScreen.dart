import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeBloc.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeEvents.dart';
import 'package:note_bad/Modules/HomeModule/bloc/HomeStates.dart';
import 'package:note_bad/Modules/NoteModule/bloc/NoteEvent.dart';
import 'package:note_bad/Modules/NoteModule/views/NoteScreen.dart';
import 'package:note_bad/Resources/constant_strings.dart';
import 'package:note_bad/routes.dart';

class HomePage extends StatefulWidget {
  static final String pageId = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String _cardHead = 'Test';
    String _cardHeadTwo = 'test2';
    String _cardDate = 'June 26, 2021';
    return BlocBuilder<HomeBloc,HomeState>(
      builder: (context, state) {
        if(state is NewNoteSelectedState){
          Future.delayed(Duration.zero, () {
            Navigator.pushNamed(context,NotePage.pageId);
          });
        }else if (state is NoteSelectedState){

        }else if (state is DeleteNoteState){

        }else if (state is MarkedNoteSelectedState){

        }else{
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
            backgroundColor: Colors.grey.withOpacity(0.4),
          ),
          appBar: AppBar(
            title: Text(
              appTitle,
            ),
          ),
          body: SafeArea(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(2, (index) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        color: Colors.blueGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(3, 8, 8, 8),
                                child: Text(
                                  _cardHead,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _cardHeadTwo,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _cardDate,
                                  style: TextStyle(
                                    color: Colors.white30,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                );
              }),
            ),
          ),
      );
 });
  }
}
