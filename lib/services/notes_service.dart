import 'dart:developer';

import 'package:supabase/supabase.dart';
import 'package:supanotes/models/note.dart';

class NotesService {
  static const notes = 'notes';

  final SupabaseClient _client;

  NotesService(this._client);

  Future<List<Note>> getNotes() async {
    final response = await _client
        .from(notes)
        .select('id, title, content, create_time, modify_time')
        .execute();
    if (response.error == null) {
      final results = response.data as List<dynamic>;
      return results.map((e) => toNote(e)).toList();
    }
    log('Error fetching notes: ${response.error!.message}');
    return [];
  }

  Future<Note?> createNote(String title, String? content) async {
    final response = await _client
        .from(notes)
        .insert({'title': title, 'content': content}).execute();
    if (response.error == null) {
      final results = response.data as List<dynamic>;
      return toNote(results[0]);
    }
    log('Error creating note: ${response.error!.message}');
    return null;
  }

  Future<Note?> updateNote(int id, String title, String? content) async {
    final response = await _client
        .from(notes)
        .update({'title': title, 'content': content, 'modify_time': 'now()'})
        .eq('id', id)
        .execute();
    if (response.error == null) {
      final results = response.data as List<dynamic>;
      return toNote(results[0]);
    }
    log('Error editing note: ${response.error!.message}');
    return null;
  }

  Future<bool> deleteNote(int id) async {
    final response = await _client.from(notes).delete().eq('id', id).execute();
    if (response.error == null) {
      return true;
    }
    log('Error deleting note: ${response.error!.message}');
    return false;
  }

  Note toNote(Map<String, dynamic> result) {
    return Note(
      result['id'],
      result['title'],
      result['content'],
      DateTime.parse(result['create_time']),
      DateTime.parse(result['modify_time']),
    );
  }
}
