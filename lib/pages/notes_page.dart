import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supanotes/models/note.dart';
import 'package:supanotes/pages/home_page.dart';
import 'package:supanotes/pages/note_page.dart';
import 'package:supanotes/services/services.dart';

class NotesPage extends StatefulWidget {
  const NotesPage();

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  Future<void> _signOut() async {
    final success = await Services.of(context).authService.signOut();
    if (success) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('There was an issue logging out.')));
    }
  }

  Future<void> _addNote() async {
    final note = await Navigator.push<Note?>(
      context,
      MaterialPageRoute(builder: (context) => NotePage()),
    );
    if (note != null) {
      setState(() {});
    }
  }

  Future<void> _editNote(Note note) async {
    final updatedNote = await Navigator.push<Note?>(
      context,
      MaterialPageRoute(builder: (context) => NotePage(note: note)),
    );
    if (updatedNote != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supanotes'),
        actions: [_logOutButton(context)],
      ),
      body: ListView(
        children: [
          FutureBuilder<List<Note>>(
            future: Services.of(context).notesService.getNotes(),
            builder: (context, snapshot) {
              final notes = (snapshot.data ?? [])
                ..sort((x, y) =>
                    y.modifyTime.difference(x.modifyTime).inMilliseconds);
              return Column(
                children: notes.map(_toNoteWidget).toList(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add note'),
        icon: Icon(Icons.add),
        onPressed: _addNote,
      ),
    );
  }

  Widget _logOutButton(BuildContext context) {
    return IconButton(
      onPressed: _signOut,
      icon: Icon(Icons.logout),
    );
  }

  Widget _toNoteWidget(Note note) {
    return Dismissible(
      key: ValueKey(note.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) =>
          Services.of(context).notesService.deleteNote(note.id),
      onDismissed: (_) => setState(() {}),
      background: Container(
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete),
      ),
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.content ?? ''),
        onTap: () => _editNote(note),
      ),
    );
  }
}
