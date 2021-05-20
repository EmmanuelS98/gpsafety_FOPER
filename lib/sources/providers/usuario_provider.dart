import 'dart:convert';
import 'package:gpsafety2/sources/models/userModel.dart';
import 'package:http/http.dart' as http;

import 'package:gpsafety2/sources/user_preferences/preferencias_usuario.dart';

class UsuarioProvider{

  final String _url = 'https://foperuaq2021-default-rtdb.firebaseio.com';
  final String _firebaseToken = 'AIzaSyB4Yqm1N5-pEL8sWoPB2oClT-J8wa9Pw-U';
  final _prefs = new PreferenciasUsuario();
  static  String userID = '';
  static  String userName = '';
 
  
   
  Future <Map<String,dynamic>> login(String email, String password ) async{
    UserModel user = new UserModel();

    print('userID: $userID' );
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

    user.mail = email;
    //user.password = password;
    user.id= decodedResp['localId'];
    user.nombre = userName;

    //aqui se configura el id del usuario
    final url = '$_url/usuarios/$userID.json?auth=${_prefs.token}';
    final resp1 = await http.put(url, body: userModelToJson(user));
    final decodedData = json.decode(resp1.body);


    print('el metodo login del usuario provider: ********************' + decodedResp['localId']);

    if(decodedResp.containsKey('idToken')){
      _prefs.token = decodedResp['idToken'];
      //salvar el token en el storage
      return{'ok' : true, 'token': decodedResp['idToken']};
    }else{
      //regresar error
      return{'ok' : false, 'token': decodedResp['error']['message']};
    }
  }


  Future <Map<String,dynamic>> nuevoUsuario(UserModel user) async{
    final authData ={
      'email'   : user.mail,
      'password': user.password,
      'nombre'  : user.nombre,
      'fotoUrl': user.fotoUrl,
      'id'      : user.id,
      'returnSecureToken': true,
    };

    final resp = await http.post(
       'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
       body: json.encode( authData  )
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    
    final authDataBD ={
      'email'   : user.mail,
      'nombre'  : user.nombre,
      'fotoUrl': user.fotoUrl,
      //'password':user.password,
      'id'      :user.id 
    };
    

    final url = '$_url/usuarios.json?auth=${_prefs.token}';
    final respbd = await http.post(url, body: json.encode( authDataBD  ));
    Map<String, dynamic> decodedData = json.decode(respbd.body);

    userID = decodedData['name'];
    userName = user.nombre;

    print('userID: $userID');



    print('aqui es ********* $decodedResp');
    print('**************** $decodedData');

    if(decodedResp.containsKey('idToken')){
      
      _prefs.token = decodedResp['idToken'];
      
      return{'ok' : true, 'token': decodedResp['idToken']};
    }else{
      //regresar error
      return{'ok' : false, 'token': decodedResp['error']['message']};
    }
  }

}