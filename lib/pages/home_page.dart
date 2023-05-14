import 'package:applenotes/pages/editing_note_page.dart';
import 'package:applenotes/models/note_data.dart';
import 'package:applenotes/models/note.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNote();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: CupertinoColors.systemGroupedBackground,
              floatingActionButton: FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.grey[300],
                onPressed: createNewNote,
                child: const Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 25.0, top: 75),
                    child: Text(
                      "Notes",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  value.getAllNotes().isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Center(
                            child: Text(
                              "Nothing Here",
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        )
                      : CupertinoListSection.insetGrouped(
                          children: List.generate(
                            value.getAllNotes().length,
                            (index) => CupertinoListTile(
                              title: Text(value.getAllNotes()[index].text),
                              onTap: () => goToNotePage(
                                  value.getAllNotes()[index], false),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    deleteNote(value.getAllNotes()[index]),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ));
  }

  void createNewNote() {
    //Create a new ID
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    //Create a blank note
    Note newNote = Note(id: id, text: "");

    //Go to note page
    goToNotePage(newNote, true);
  }

  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingNotePage(
          note: note,
          isNewNote: isNewNote,
        ),
      ),
    );
  }

  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }
}
