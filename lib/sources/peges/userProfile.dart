import 'package:flutter/material.dart';
import 'package:gpsafety2/sources/user_preferences/preferencias_usuario.dart';

import 'login.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  
  

  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: FlatButton(
        child: Text('cerrar Sesion'),
        onPressed: _cerrarSesion,
      ),
    );
  }

  _cerrarSesion(){
    final _userPreferences = PreferenciasUsuario();
    _userPreferences.token = '';
    Navigator.pushReplacementNamed (context, 'login');
  }

  
}