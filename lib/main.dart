import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(GoogleSignInApp());
}

class GoogleSignInApp extends StatefulWidget {
  const GoogleSignInApp({Key? key}) : super(key: key);

  @override
  _GoogleSignInAppState createState() => _GoogleSignInAppState();
}

class _GoogleSignInAppState extends State<GoogleSignInApp> {
  GoogleSignIn __googleSignIn = GoogleSignIn(scopes: ['email']);
  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = __googleSignIn.currentUser;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              'Google Sign In (Signed ' + (user == null ? 'out' : 'in') + ')'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  child: Text('Sign In'),
                  onPressed: user != null
                      ? null
                      : () async {
                          await __googleSignIn.signIn();
                          setState(() {});
                        }),
              ElevatedButton(
                  child: Text('Sign Out'),
                  onPressed: user == null
                      ? null
                      : () async {
                          await __googleSignIn.signOut();
                          setState(() {});
                        }),
            ],
          ),
        ),
      ),
    );
  }
}
