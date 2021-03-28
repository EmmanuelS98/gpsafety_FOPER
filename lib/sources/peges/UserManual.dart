import 'package:flutter/material.dart';

class UserManual extends StatefulWidget {
  UserManual({Key key}) : super(key: key);

  @override
  _UserManualState createState() => _UserManualState();
}

class _UserManualState extends State<UserManual> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(child: Text('manual')),
    );
  }
}