import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/note.dart';

class HiveDatabase {
  //Reference our hive box
  final _myBox = Hive.box('note_database');
  
  //Load notes
  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];
    //If notes exists, return that else return empty list
    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
      for (int i = 0; i < savedNotes.length; i++) {
        //Create individual note
        Note individualNotes =
            Note(id: savedNotes[i][0], text: savedNotes[i][1]);
        //Add to list
        savedNotesFormatted.add(individualNotes);
      }
    } else {
      // savedNotesFormatted.add(Note(id: 0, text: "Hello World!"));
    }
    return savedNotesFormatted;
  }

  //Save notes
  void savedNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [];

    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }

    //Then store into hive
    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}
