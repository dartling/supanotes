import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:supabase/supabase.dart';
import 'package:supanotes/secrets.dart';
import 'package:supanotes/services/notes_service.dart';

import 'auth_service.dart';

class Services extends InheritedWidget {
  final AuthService authService;
  final NotesService notesService;

  Services._({
    required this.authService,
    required this.notesService,
    required Widget child,
  }) : super(child: child);

  factory Services({required Widget child}) {
    final client = SupabaseClient(supabaseUrl, supabaseKey);
    final authService = AuthService(client.auth);
    final notesService = NotesService(client);
    return Services._(
      authService: authService,
      notesService: notesService,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static Services of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Services>()!;
  }
}
