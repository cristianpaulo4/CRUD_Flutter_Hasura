import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hasura/home.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class Tela_Login extends StatefulWidget {
  @override
  _Tela_LoginState createState() => _Tela_LoginState();
}

class _Tela_LoginState extends State<Tela_Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Gmail'),
        ),
        body: FutureBuilder<FirebaseUser>(
          future: _logar(),
          builder: (_, d) {
            if (d.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(d.data.photoUrl),
                      radius: 50,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(child: Text(d.data.displayName)),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('Login'),
                      onPressed: () async {
                        await _logar();
                      },
                    ),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Future<FirebaseUser> _logar() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    final FirebaseUser user =(await _auth.signInWithCredential(credential)).user;
    print("Id Usuario " + googleUser.email);
    return user; 
  }
}
