import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supanotes/pages/home_page.dart';
import 'package:supanotes/pages/notes_page.dart';
import 'package:supanotes/services/services.dart';
import 'package:supanotes/utils.dart';

void main() {
  runApp(SupanotesApp());
}

class SupanotesApp extends StatelessWidget {
  static const supabaseGreen = Color.fromRGBO(101, 217, 165, 1.0);

  const SupanotesApp();

  @override
  Widget build(BuildContext context) {
    return Services(
      child: MaterialApp(
        title: 'Supanotes',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: toMaterialColor(supabaseGreen),
        ),
        home: Builder(
          builder: (context) {
            return FutureBuilder<bool>(
              future: Services.of(context).authService.recoverSession(),
              builder: (context, snapshot) {
                final sessionRecovered = snapshot.data ?? false;
                return sessionRecovered ? NotesPage() : HomePage();
              },
            );
          },
        ),
      ),
    );
  }
}
