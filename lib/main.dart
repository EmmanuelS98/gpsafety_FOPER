import 'package:flutter/material.dart';

import 'package:gpsafety2/sources/blocks/provider.dart';
import 'package:gpsafety2/sources/peges/UserManual.dart';
import 'package:gpsafety2/sources/peges/devises.dart';
import 'package:gpsafety2/sources/peges/dispositivo.dart';
import 'package:gpsafety2/sources/peges/homePage.dart';
import 'package:gpsafety2/sources/peges/login.dart';
import 'package:gpsafety2/sources/peges/newDevise.dart';
import 'package:gpsafety2/sources/peges/registro.dart';
import 'package:gpsafety2/sources/peges/userProfile.dart';
import 'package:gpsafety2/sources/user_preferences/preferencias_usuario.dart';

/* import 'package:gpsafety/src/peges/homePage.dart';
import 'package:gpsafety/src/peges/homePageScreen.dart';
import 'package:gpsafety/src/peges/login.dart';
import 'package:gpsafety/src/peges/newDevise2.dart';
import 'package:gpsafety/src/peges/registro.dart';
import 'package:gpsafety/src/peges/userProfile.dart';
*/

void main() async{
  WidgetsFlutterBinding.ensureInitialized();  
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}
 

//aqui es donde se iniciali za todo el programa iniciando con un stateleswidget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = new PreferenciasUsuario();
    //print(prefs.token);
    //este widget retorna un provider que sera la base de nuestro arbol de widgets
    return Provider( 
      //su hijo sera un material app el cual iniciara nuestro programa
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GPSafety',
        initialRoute: 'login',
        //RUTAS
        routes: {
          'login'       :(BuildContext context )=> LoginPage(),
          'registro'    :(BuildContext context )=> Registro(),

          'homePage'    :(BuildContext context )=> HomePage(),
          'principal'   :(BuildContext context )=> Devises(),
          'nuevoDisp'   :(BuildContext context )=> NewDevise(),
          'userProfile' :(BuildContext context )=> UserProfile(),
          'userManual'  :(BuildContext context )=> UserManual(),
          'infoDisp'    :(BuildContext context )=> InfoDispositivo(), 
        },
        theme: ThemeData(
          primaryColor: Colors.greenAccent[400],
          
        ),
        
      ),
    );
  }
}
