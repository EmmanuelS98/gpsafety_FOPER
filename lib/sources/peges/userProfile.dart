import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gpsafety2/sources/blocks/provider.dart';
import 'package:gpsafety2/sources/models/dispositivosModel.dart';
import 'package:gpsafety2/sources/peges/homePage.dart';
import 'package:gpsafety2/sources/user_preferences/preferencias_usuario.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  
  DispositivoModel dispositivo = new DispositivoModel();
  File foto= null;
  

  //////////////////////////////BUILD del Stateful/////////////////////////////////////////


  @override
  Widget build(BuildContext context) {

    final DispositivoModel dispData = ModalRoute.of(context).settings.arguments;
    final usuarioBloc = Provider.of(context);
    final size = MediaQuery.of(context).size;



    if( dispData != null){
      dispositivo = dispData;   
    }

    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Text('Perfil de Usuario',style: TextStyle(color: Colors.white,fontSize: 22)),
          ) ,
          leading: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 17),
            child: Icon(Icons.person_pin_circle_sharp,color: Colors.white,size: 35,),
          ),
        ),
      ),

      body: Center(

        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Datos de usuario (Foto, nombre, correo)
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: _datosUsuario(size),
            ),
            Padding(
              padding: const EdgeInsets.all(120.0),
              child: Divider( height: 25,),
            ),
            //Boton cerrar sesion
            _botonCerrarSesion(),
            //
            
          ],
        ),
      ),
    );
  }
  ///////////////////////DATOS USUARIO//////////////////////////////////////////

  Widget _datosUsuario(Size size) {
    

    return  Padding(
      padding: const EdgeInsets.only(left: 10 ),
      child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _fotoPerfil(context,size),
            _formularioUsuario(size),
          ],
      ),
    );
  }
  //se valida si tiene o no foto de perfil
  Widget _fotoPerfil(BuildContext context, Size size) {
  
    if (dispositivo.fotoUrl != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Stack(
          children: [
            _pintarFoto(size),
            Positioned(
              child: _botonFotoPerfil(),
              bottom: 0,
              right: 0,
            )
          ],
          overflow: Overflow.visible,
        ),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Stack(
            children: [
              Container(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
                
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200)
                ),
                height: size.width*0.45,
                width: size.width*0.45,
              ),
              Positioned(
                child: _botonFotoPerfil(),
                bottom: 0,
                right: 0,
              )
            ],
            overflow: Overflow.visible,
          )
      );
    }
  }
  //se pinta la foto de perfil
  Widget _pintarFoto(Size size) {
    if(foto !=null){
      return Container(
        height: size.width*0.45,
        width: size.width*0.45,
        child: new CircleAvatar(
          backgroundImage: new FileImage(foto),
          radius: 200,
      ));
    }else{
      return Container(
        height: size.width*0.45,
        width: size.width*0.45,
        child: new CircleAvatar(

          backgroundImage: NetworkImage(dispositivo.fotoUrl),
          radius: 200,
      ));
    }
  }
  //boton para elegir nueva foto
  Widget _botonFotoPerfil() {
    return CircleAvatar(
      maxRadius: 30,
      child: RaisedButton(
        onPressed: () {
          _openGallery();
        },
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 27,
        ),
        color: Colors.transparent,
        elevation: 0,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
      ),
      backgroundColor: Color.fromRGBO(23, 66, 118, 1),
    );
  }
  //Se abre la galeria
  _openGallery() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    try{
      foto = File(pickedFile.path);
    }catch(exc){
      print(exc);
    }
    if(foto != null)
   
    if(dispositivo.fotoUrl == null){
      dispositivo.fotoUrl = '';
    }

    setState(() {});
  }

  Widget _formularioUsuario(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 60),
      child: Container(
        height: size.width*0.38,
        width: size.width * 0.44,
        //color: Colors.grey,
        child: Column(
          children: [
            ListTile(
              //horizontalTitleGap: -10 , //
              title: Text(
                'Usuario',
                style: TextStyle(fontSize: 13,color: Colors.black ),
              ),
              subtitle: Text('José Aguirre Hernandez',style: TextStyle(color: Colors.black87,fontSize: 18),),
              contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 3),          
            ),
            
            ListTile(
              //horizontalTitleGap: -10 , //
              title: Text(
                'Correo',
                style: TextStyle(fontSize: 13,color: Colors.black ),
              ),
              subtitle: Text('josE@gmail.com',style: TextStyle(color: Colors.black87,fontSize: 18),),
              contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),            
            ),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////BOTON CERRAR SESION///////////////////////////////////////////////////
  Widget _botonCerrarSesion(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: TextButton(
        child: Text('Cerrar Sesión'),
        onPressed: _cerrarSesion,
        style: TextButton.styleFrom(
          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
          primary: Colors.white,
          backgroundColor: Color.fromRGBO(215, 35, 35, 1)
        ),
      ),
    );
  }

  _cerrarSesion(){
    final _userPreferences = PreferenciasUsuario();
    _userPreferences.token = '';
    Navigator.pushReplacementNamed (context, 'login');
  }

}


