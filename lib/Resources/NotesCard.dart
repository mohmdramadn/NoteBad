import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_bad/Services/NoteModel.dart';

final _lightColors = [
  Colors.yellow.shade600,
  Colors.lightGreen.shade300,
  Colors.blueAccent.shade200,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.deepPurpleAccent.shade200,
];


class NotesCard extends StatelessWidget {
  NotesCard({
    Key key,
    this.note,
    this.index
});

  final Note note;
  final int index;
  @override
  Widget build(BuildContext context) {

    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(note.createdDate);
    //final minHeight = getMinHeight(index);

    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            //width: 1,
          ),
        ),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  note.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  note.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
//              SizedBox(
//                height: 5,
//              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  time,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
