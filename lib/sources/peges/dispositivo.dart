import 'dart:io';

import 'package:flutter/material.dart';

import 'package:gpsafety2/sources/blocks/provider.dart';
import 'package:gpsafety2/sources/models/dispositivosModel.dart';
import 'package:gpsafety2/sources/peges/homePage.dart';
import 'package:gpsafety2/sources/utils/alerta.dart';
import 'package:gpsafety2/sources/utils/alertaEliminar.dart';

class InfoDispositivo extends StatefulWidget {
  @override
  _InfoDispositivoState createState() => _InfoDispositivoState();
}

class _InfoDispositivoState extends State<InfoDispositivo> {
  
  DispositivoModel dispositivo = new DispositivoModel();
  File foto= null;
  

  @override
  Widget build(BuildContext context) {
    
    final DispositivoModel dispData = ModalRoute.of(context).settings.arguments;
    if( dispData != null){
      dispositivo = dispData;   
    }


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text('Info. Dispositivo'),
      ),
      body: ListView(
        shrinkWrap: true,
        //padding: EdgeInsets.only(),
        children: [
            //Foto de perfil
            _fotoPerfil(context),
            Divider(indent: 15, endIndent: 15,height: 20,),
            //Info usuario
            _infoDisp(context),
            //Mapa y opciones
            _mapaAcciones(context)
          ],
      ),
      
      
      
      /* Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Foto de perfil
            _fotoPerfil(context),
            Divider(indent: 15, endIndent: 15,height: 20,),
            //Info usuario
            _infoDisp(context),
            //Mapa y opciones
            _mapaAcciones(context)
          ],
        ) */
    );
  }

//widgets para mostrar la foto de dispositivo
  Widget _fotoPerfil(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child:  _pintarFoto(),
    );
  }
  Widget _pintarFoto() {
    return Container(
      height: 230,
      width: 230,
      child: new CircleAvatar(

        backgroundImage: NetworkImage(dispositivo.fotoUrl,),
        radius: 200,
      )
    );
  }
  //Widget para info del dispositivo
  Widget _infoDisp(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //izquierdo con respecto a la pantalla, ahi es donde se acomodara
        _izquierdo(size),
        //izquierdo con respecto a la pantalla, ahi es donde se acomodara
        _derecho(size),
      ],
    );
  }
  Widget _izquierdo(Size size){
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Container(
        //color: Colors.redAccent,
        height: 145,
        width: size.width * .55,
        child: Column(
          children: [
            ListTile(
              horizontalTitleGap: -10 , //
              title: Text(
                dispositivo.nombre,
                style: TextStyle(fontSize: 25,color: Colors.black ),
              ),
              subtitle: Text('dispositivo',style: TextStyle(color: Colors.grey,fontSize: 15),),
              leading: Icon(Icons.person_pin_circle_rounded),
              contentPadding: EdgeInsets.fromLTRB(5, 0, 2, 0),          
            ),
            ListTile(
              horizontalTitleGap: -10 , //
              title: Text(
                dispositivo.id,
                style: TextStyle(fontSize: 18,color: Colors.black ),
              ),
              subtitle: Text('Identificador',style: TextStyle(color: Colors.grey,fontSize: 15),),
              leading: Icon(Icons.qr_code_rounded),
              contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),          
            ),
          ],  
        ),
      ),
    );
  }

  Widget _derecho(Size size){
    String estado = '';
    
    if(dispositivo.activo == true) {
      estado = 'Encendido';
    }
    else{ estado = 'Apagado';}

    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Container(
        //color: Colors.purple,
        height: 75,
        width: size.width * .35,
        child: ListTile(
          horizontalTitleGap: -10 , //
          title: Text(
            estado,
            style: TextStyle(fontSize: 18,color: Colors.black ),

          ),
          subtitle: Text('Estado',style: TextStyle(color: Colors.grey,fontSize: 15),),
          leading: Icon(Icons.offline_bolt_rounded,),
            contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),          
        ),
      ),
    );
  }
  Widget _mapaAcciones (BuildContext context){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _mapa(),
        opciones()
      ]
      
    );
  }
  Widget _mapa(){
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
      child: Container(
        
        height: size.height *  0.37,
        width:  size.width  *  0.55,
        color: Colors.blueGrey,
      ),
    );
  }
  Widget opciones(){
    final size = MediaQuery.of(context).size;
    final dispositivosBloc = Provider.dispositivosBloc(context);
    


    return Container(
      width: (size.width * 0.45) - 20  ,
      height: size.height * 0.40,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children:[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: (){},
                child: Container(
                  height: 70,
                  width: 70,
                  child: Icon(Icons.remove_red_eye,size: 45, color: Colors.white,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70.0),
                    color: Color.fromRGBO(23, 66, 118, 1)),
                )
              ),
              TextButton(
                onPressed: (){ 
                  Navigator.pushNamed(context, 'nuevoDisp',arguments: dispositivo);
                },
                child: Container(
                  height: 70,
                  width: 70,
                  child: Icon(Icons.edit,size: 45,color: Colors.white,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70.0),
                    color: Color.fromRGBO(23, 66, 118, 1),
                  ),
                )
              ),
              
            ],
          ) ,
          Padding(
            padding: const EdgeInsets.fromLTRB(90,260,0,10),
            //padding: const EdgeInsets.fromLTRB(0,0,0,0),
            child: TextButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: ( context ){
                          return AlertDialog(
                            title: Text('Cuidado!!!'),
                            content: Text('Seguro que quieres eliminar este dispositivo?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed:(){ 
                                  dispositivosBloc.borrarDispositivo(dispositivo.id);
                                  Navigator.pushNamed(context, 'principal',);
                                 },
                                child: Text('aceptar' , style: TextStyle(color: Color.fromRGBO(23, 66, 118, 1)),)
                              ),
                              TextButton(
                                onPressed:(){Navigator.of(context).pop();} ,
                                child: Text('cancelar', style: TextStyle(color: Color.fromRGBO(23, 66, 118, 1)),),
                                autofocus: true,
                              ),
                              
                            ],
                          );
                        }
                      );
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    
                    child: Icon(Icons.delete,size: 40, color: Colors.red[700]),
                  ),
                ),
          ) 
        ] 
      ),
    );
  }
}