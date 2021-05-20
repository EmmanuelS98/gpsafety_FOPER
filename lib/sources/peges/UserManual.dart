import 'package:flutter/material.dart';
import 'package:gpsafety2/sources/variables/variables.dart';

class UserManual extends StatefulWidget {
  UserManual({Key key}) : super(key: key);

  @override
  _UserManualState createState() => _UserManualState();
}

class _UserManualState extends State<UserManual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Text('Manual',style: TextStyle(color: Colors.white,fontSize: 22)),
          ) ,
          leading: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 17),
            child: Icon(Icons.person_pin_circle_sharp,color: Colors.white,size: 35,),
          ),
        ),
      ),
      body: Center(
        child:SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text('¡Bienvenido!',style:TextStyle(fontSize: 40,) ,),
              ),
              Padding (
                padding: const EdgeInsets.only(right: 20,left: 20,top: 30),
                child: Text(bienvenida,style:TextStyle(fontSize: 18,),textAlign: TextAlign.center, ),
              ),
              Divider(height: 50,),
              Padding(
                padding: const EdgeInsets.only(right: 170,bottom: 30),
                child: Text('Pagina principal',style:TextStyle(fontSize: 25),),
              ),
              Image(image: AssetImage("assets/home.png"),),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20),
                child: Text(paginaPrincipal,style:TextStyle(fontSize: 18,),textAlign: TextAlign.justify, ),
              ),
              Divider(height: 50,),
              Padding(
                padding: const EdgeInsets.only(right: 80,bottom: 30),
                child: Text('Información de Dispositivo',style:TextStyle(fontSize: 25),),
              ),
              Image(image: AssetImage("assets/infoDisp.png"),),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20),
                child: Text(infoDisp,style:TextStyle(fontSize: 18,),textAlign: TextAlign.justify, ),
              ),
              Image(image: AssetImage("assets/newDevise.png"),),
              Image(image: AssetImage("assets/userProfile.png"),),
            ],
          ),
        ),
      ),
    );
  }
}