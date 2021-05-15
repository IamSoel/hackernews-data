import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_stateful/hackernews/screens/app.dart';
import 'package:login_stateful/screen/login.dart';

void main() => runApp(AppNews());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login Stateful Style'),
        ),
        body: LoginScreen(),
      ),
    );
  }
}
