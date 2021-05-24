import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supanotes/models/note.dart';
import 'package:supanotes/services/services.dart';

class NotePage extends StatefulWidget {
  final Note? note;

  const NotePage({this.note});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  Future<void> _saveNote() async {
    final title = _titleController.text;
    final content = _contentController.text;
    if (title.isEmpty) {
      _showSnackBar('Title cannot be empty.');
      return;
    }
    final note = await _createOrUpdateNote(title, content);
    if (note != null) {
      Navigator.pop(context, note);
    } else {
      _showSnackBar('Something went wrong.');
    }
  }

  Future<Note?> _createOrUpdateNote(String title, String content) {
    final notesService = Services.of(context).notesService;
    if (widget.note != null) {
      return notesService.updateNote(widget.note!.id, title, content);
    } else {
      return notesService.createNote(title, content);
    }
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? 'Edit note' : 'New note'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _contentController,
              decoration: InputDecoration(hintText: 'Content'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveNote,
        icon: Icon(Icons.save),
        label: Text('Save'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
