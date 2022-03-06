import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(GoogleSignin());
}

class GoogleSignin extends StatefulWidget {
  const GoogleSignin({Key? key}) : super(key: key);

  @override
  _GoogleSigninState createState() => _GoogleSigninState();
}

class _GoogleSigninState extends State<GoogleSignin> {
  String? name;
  String? email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("hello"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    GoogleSignIn _googleSignIn = GoogleSignIn(
                      scopes: [
                        'email',
                        'https://www.googleapis.com/auth/contacts.readonly',
                      ],
                    );
                    _googleSignIn.signIn().then((googleAccount) {
                      googleAccount?.authentication.then((authentication) {


                      });
                    });
                  },
                  child: Text("Click"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
