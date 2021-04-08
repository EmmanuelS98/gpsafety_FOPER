//import 'dart:html';
import 'package:flutter/material.dart';

import 'package:gpsafety2/sources/blocks/provider.dart';
import 'package:gpsafety2/sources/user_preferences/preferencias_usuario.dart';
import 'package:gpsafety2/sources/providers/usuario_provider.dart';
import 'package:gpsafety2/sources/blocks/login_bloc.dart';
import 'package:gpsafety2/sources/utils/alerta.dart';

class LoginPage extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider();
  final _userPreferences = PreferenciasUsuario();


  @override
  Widget build(BuildContext context) {
    
    
    print(_userPreferences.token);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    final fondo = Container(
      height: size.height *.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          
          colors: <Color>[
            Color.fromRGBO(12, 105, 139, 1.0),//75, 175, 79
            Color.fromRGBO(34, 40, 49, 1.0),//140, 194, 73
          ]
         ),
      ),
    );

    final crearCirculos = Container(
      height: 200.0,
      width: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, .5)
      ),
    );

    return Stack(
      children: <Widget>[
        fondo,
        
        Container(
          padding: EdgeInsets.only(top: 100.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle,color: Colors.white, size: 100.0,),
              SizedBox(height: 5.0,width: double.infinity),
              Text("GPSafety", style: TextStyle(color: Colors.white,fontSize: 20),)
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {

    final bloc = Provider.of(context);//aqui se obtienen los datos de los form de login
    final size = MediaQuery.of(context).size;

    

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 230,
            )
          ),

          Container(
           width: size.width * .85 , 
           margin: EdgeInsets.symmetric(vertical: 30.0),
           padding: EdgeInsets.symmetric(vertical:50.0) ,
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(5.0),
             boxShadow: <BoxShadow>[
               BoxShadow(
                 color: Colors.black26,
                 blurRadius: 3.0,
                 offset: Offset(0.0,5.0) ,
                 spreadRadius: 3.0
               )
             ],
           ),
           child: Column(
             children: <Widget>[
              Text("Ingreso", style: TextStyle(fontSize: 26.0,color: Color.fromRGBO(12, 105, 139, 1)),),
              SizedBox(height: 50.0),
              _crearEmail(bloc),
              SizedBox(height: 30.0),
              _crearPasword(bloc),
              SizedBox(height: 30.0),
              _crearBoton(bloc)
             ],
           ),
          ),

          TextButton(
            onPressed: ()=>Navigator.pushReplacementNamed(context, 'registro'),
             child:Text('Regístrate',style: TextStyle(color: Color.fromRGBO(12, 105, 139, 1)),) ,),
          SizedBox(height: 100.0,)
        ],
      ),
    );
  }

  Widget _crearEmail( LoginBloc bloc) {
    
    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,  
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email,color: Color.fromRGBO(12, 105, 139, 1),),
              hintText: "ejemplo@correo.com",
              labelText: "Correo electrònico",  
              //counterText: snapshot.data,
              errorText: snapshot.error,
              //helperStyle: TextStyle(color: Colors.red),//
              //counterStyle: TextStyle(color: Colors.red),//
              //labelStyle: TextStyle(color: Colors.red),
            ),
            onChanged: bloc.changeEmail,//cada que escribe el usuario el stream guarda los nuevos argumentos
          ),
        );  
      },
    );
  }

  Widget _crearPasword( LoginBloc bloc ) {
    
    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.text,  
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline,color: Color.fromRGBO(12, 105, 139, 1)),
              labelText: "Contraseña",
              //counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword, 
          ),
          
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 65.0, vertical: 15.0),
            child: Text("Ingresar",style: TextStyle(fontSize: 16),),
          ),
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(5.0)
          ),
          elevation: 0.0 ,
          color: Color.fromRGBO(12, 105, 139, 1),
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=>_login( context , bloc) : null
        );
      }
    );  
  }

  _login(BuildContext context ,LoginBloc bloc)async{
   
    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    if(info['ok']){
      Navigator.pushReplacementNamed(context, 'homePage');
    } else {
      mostrarAlerta(context, 'Correo y/o contraseña incorrecta');
    }
    //Navigator.pushReplacementNamed (context, 'homePage');
  }



}