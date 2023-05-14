import 'package:applenotes/data/hive_database.dart';
import 'package:flutter/material.dart';
import 'note.dart';

class NoteData extends ChangeNotifier {
//Hive database instance
  final db = HiveDatabase();

//Overall List of Notes
  List<Note> allNotes = [];

//Initialize the list
  void initializeNote() {
    allNotes = db.loadNotes();
  }

// Get Notes
  List<Note> getAllNotes() {
    return allNotes;
  }

// Add a new Note
  void addNewNote(Note note) {
    allNotes.add(note);
    db.savedNotes(allNotes);
    notifyListeners();
  }

// Update a Note
  void updateNote(Note note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      //Find relevant note
      if (allNotes[i].id == note.id) {
        //replace text
        allNotes[i].text = text;
      }
    }
    db.savedNotes(allNotes);
    notifyListeners();
  }

// Delete a Note
  void deleteNote(Note note) {
    allNotes.remove(note);
    db.savedNotes(allNotes);
    notifyListeners();
  }
}
