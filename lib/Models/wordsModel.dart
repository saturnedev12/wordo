class WordsModel{
  final String? english_note;
  final String? french_note;
  final bool? important;

  WordsModel({ this.english_note, this.french_note, this.important});

  Map<String, dynamic> toMap()=> {
    'english_note':english_note,
    'french_note':french_note
  };



}

