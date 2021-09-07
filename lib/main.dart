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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: Image(
                height: 100,
                alignment: Alignment.center,
                image: AssetImage('assets/images/logo.jpeg'),
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
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  icon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Champs requis';
                  }
                  return null;
                },
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  primary: Color(0xff9B3F1B), alignment: Alignment.bottomLeft),
              child: Text('Mot de passe oublie ?'),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff6A290F),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacementNamed(context, '/second');
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
