import 'package:flutter/material.dart';
import 'package:login_stateful/bloclogin/loginscreenbloc.dart';

class BlocLogin extends StatefulWidget {
  @override
  _BlocLoginState createState() => _BlocLoginState();
}

class _BlocLoginState extends State<BlocLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login Bloc'),
        ),
        body: LoginScreenBloc(),
      ),
    );
  }
}
