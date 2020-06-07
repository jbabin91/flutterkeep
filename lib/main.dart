import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutterkeep/models/user.dart';

import 'screens/screens.dart';

void main() => runApp(NotesApp());

/// Root widget of the application
class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamProvider.value(
        initialData: CurrentUser.initial,
        value: FirebaseAuth.instance.onAuthStateChanged
            .map((user) => CurrentUser.create(user)),
        child: Consumer<CurrentUser>(
          builder: (context, user, _) => MaterialApp(
            title: 'Flutter Keep',
            home: user.isInitialValue
                ? Scaffold(body: const Text('Loading...'))
                : user.data != null ? HomeScreen() : LoginScreen(),
          ),
        ),
      );
}
