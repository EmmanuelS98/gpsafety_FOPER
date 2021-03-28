import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:gpsafety2/sources/user_preferences/preferencias_usuario.dart';

class UsuarioProvider{

  final String _firebaseToken = 'AIzaSyB4Yqm1N5-pEL8sWoPB2oClT-J8wa9Pw-U';
  final _prefs = new PreferenciasUsuario();

 
  
  
  Future <Map<String,dynamic>> login(String email, String password ) async{
    final authData ={
      'email'   : email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken  ',
       body: json.encode( authData  )
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print('el metodo login del usuario provider: ********************$decodedResp');

    if(decodedResp.containsKey('idToken')){
      _prefs.token = decodedResp['idToken'];
      //salvar el token en el storage
      return{'ok' : true, 'token': decodedResp['idToken']};
    }else{
      //regresar error
      return{'ok' : false, 'token': decodedResp['error']['message']};
    }
  }


  Future <Map<String,dynamic>> nuevoUsuario(String email, String password) async{
    final authData ={
      'email'   : email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
       'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
       body: json.encode( authData  )
    );
    

    Map<String, dynamic> decodedResp = json.decode(resp.body);


    print('*****************************************************');
    print('*****************************************************');
    print('*****************************************************');
    print('aqui es ********* $decodedResp');
    

    if(decodedResp.containsKey('idToken')){
      
      _prefs.token = decodedResp['idToken'];
      
      return{'ok' : true, 'token': decodedResp['idToken']};
    }else{
      //regresar error
      return{'ok' : false, 'token': decodedResp['error']['message']};
    }
  }

}