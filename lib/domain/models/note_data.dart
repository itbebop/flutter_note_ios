import 'package:applenotes/data/hive_database.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:applenotes/env.dart';
import 'note.dart';

class NoteData extends ChangeNotifier {
//Hive database instance
  final db = HiveDatabase();

//Overall List of Notes
  List<Note> allNotes = [];
  Dio dio = Dio();

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
  var logger = Logger();
// Add a new Note to DBUpgrade plan
  Future addNewNoteToDb(Note note) async {
    var formData = FormData.fromMap(
      {
        "id": note.id,
        "content": note.text,
        "createdAt": DateTime.now().toString()
      }
    );
    logger.d(note.id);
    logger.d(note.text);
    return await dio.post("${Env.URL_PREFIX}/create.php", data: formData);
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
