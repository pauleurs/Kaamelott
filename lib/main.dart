import 'package:flutter/material.dart';

import 'teammates.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kaamelott",
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/second': (context) => TeammatesModel(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  var mail;
  var passworld;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ClipOval(
                child: Image(
                  height: 150,
                  alignment: Alignment.center,
                  image: AssetImage('assets/images/logo.jpeg'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.mail),
                  hintText: 'Adresse mail',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Champs requis';
                  }
                  mail = value;
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  icon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Champs requis';
                  }
                  passworld = value;
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 15, 30, 0),
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  primary: Color(0xff9B3F1B),
                ),
                child: Text('Mot de passe oublie ?'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 130, 30, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff6A290F),
                ),
                onPressed: () {
                  print(mail);
                  print(passworld);
                  if (_formKey.currentState!.validate()) {
                    print(mail);
                    print(passworld);
                    if (mail == "welcome@imhotep.io" &&
                        passworld == "MySecretPassword1234#") {
                      Navigator.pushReplacementNamed(context, '/second');
                    } else {
                      final snackBar = SnackBar(
                        content: Text("Email ou mot de passe"),
                        elevation: 150,
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
                child: new Align(
                  alignment: Alignment.bottomCenter,
                  child: new Text('Se connecte'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
