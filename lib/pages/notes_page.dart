import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supanotes/pages/home_page.dart';
import 'package:supanotes/services/services.dart';

class NotesPage extends StatelessWidget {
  const NotesPage();

  Future<void> _signOut(BuildContext context) async {
    final success = await Services.of(context).authService.signOut();
    if (success) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('There was an issue logging out.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supanotes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Your notes will show up here.'),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await _signOut(context);
              },
              icon: Icon(Icons.login),
              label: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
