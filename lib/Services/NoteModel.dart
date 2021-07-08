final String tableNotes = 'notes';

class NoteFields {
  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String createdDate = 'date';

  static final List<String> values = [
    id,title,description,createdDate
  ];
}

class Note {
  final int id;
  final String title;
  final String description;
  final DateTime createdDate;

  Note({this.id, this.title, this.description, this.createdDate});

  Map<String, Object> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.createdDate: createdDate.toIso8601String(),
      };

  Note copy({
    int id,
    String title,
    String description,
    DateTime createdDate,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdDate: createdDate ?? this.createdDate,
      );

  static Note fromJson(Map<String, Object> json) => Note(
    id: json[NoteFields.id] as int,
    title: json[NoteFields.title] as String,
    description: json[NoteFields.description] as String,
    createdDate: DateTime.parse(json[NoteFields.createdDate] as String),
  );
}
