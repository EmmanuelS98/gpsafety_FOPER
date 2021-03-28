import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';



import 'package:gpsafety2/sources/models/dispositivosModel.dart';
import 'package:gpsafety2/sources/providers/dispositivosProvider.dart';
import 'package:gpsafety2/sources/utils/alerta.dart';
import 'homePage.dart';
//import 'homePageScreen.dart';

class NewDevise extends StatefulWidget {
  NewDevise({Key key}) : super(key: key);

  @override
  _NewDeviseState createState() => _NewDeviseState();
}

class _NewDeviseState extends State<NewDevise> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final dispProvider = new DispositivosProvider();
  
  //creacion del producto
  DispositivoModel dispositivo = new DispositivoModel();
  bool _guardado = false;

  File foto= null;
  bool _picked = false;
  String id = '';
  

  @override
  Widget build(BuildContext context) {
    final DispositivoModel dispData = ModalRoute.of(context).settings.arguments;
    if( dispData != null){
      dispositivo = dispData;   
    }

    //fina l List<Widget> _tabItems = [UserProfile(),HomePageScreen(),UserManual(),];
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        elevation: 10.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 130.0),
          child: Text(
            'Nuevo Dispositivo',
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _fotoPerfil(context),
                //_botonFotoPerfil(),
                _nombreDisp(),
                _idDispo(),
                //_crearActivo(),
                _crearBoton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fotoPerfil(BuildContext context) {
  
    if (dispositivo.fotoUrl != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Stack(
          children: [
            _pintarFoto(),
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
          padding: const EdgeInsets.only(top: 30),
          child: Stack(
            children: [
              Container(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
                
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200)
                ),
                height: 230,
                width: 230,
              ),
              Positioned(
                child: _botonFotoPerfil(),
                bottom: 0,
                right: 0,
              )
            ],
            overflow: Overflow.visible,
          ));

    
    }
  }

  Widget _pintarFoto() {
    if(foto !=null){
      return Container(
        height: 230,
        width: 230,
        child: new CircleAvatar(
          backgroundImage: new FileImage(foto),
          radius: 200,
      ));
    }else{
      return Container(
        height: 230,
        width: 230,
        child: new CircleAvatar(
          backgroundImage: NetworkImage(dispositivo.fotoUrl),
          radius: 200,
      ));
    }
    
    

    /* Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0) ),
      child: Image(
        image: AssetImage(_imageFile?.path??'assets/no-image.png'),
        height: 200.0,
      ),
    ); */
  }

  Widget _botonFotoPerfil() {
    return CircleAvatar(
      maxRadius: 35,
      child: RaisedButton(
        onPressed: () {
          _openGallery();
        },
        child: Icon(
          Icons.camera_alt,
          color: Colors.grey[300],
          size: 30,
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
      backgroundColor: Colors.orange[600],
    );

    /* return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(

        height: 60,
        width: 180,
        decoration: BoxDecoration(

        ),
        
        child: RaisedButton(
          
          onPressed: (){
            _openGallery();
          },
          elevation: 5.0, 
          child: Text('Seleccionar Foto de Dispositivo', 
            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 15 ,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
          color: Color.fromRGBO(224, 136, 75, 1),

        ),
      ),
    ); */
  }

  Widget _exitApp(BuildContext context) {
    return AlertDialog(
      title: Text('ey amigo!'),
      content: Text('Quieres salir de Galería?'),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, 'nuevoDispo');
            },
            child: Text('Sí')),
        FlatButton(
            onPressed: () {
              setState(() {
                _picked = true; 
              });
            },
            child: Text('No'))
      ],
    );
  }

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

  Widget _nombreDisp() {
    
    return  Padding(
      padding: const EdgeInsets.fromLTRB(20, 80, 20, 5),
      child: TextFormField(
        initialValue: dispositivo.nombre,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
           labelText: 'Nombre Dispositivo',
           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onSaved: (value) => dispositivo.nombre  = value ,
        validator: (value){
          if(value.length < 2){
            return 'ingrese nombre correcto';
          }else{
            return null;
          }
        },
      ),
    );
    
    /* return Padding(
      padding: const EdgeInsets.fromLTRB(20, 80, 20, 5),
      child: TextFormField(
        initialValue: dispositivo.nombre,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: 'Nombre del Dispositivo:',
        ),
        onSaved: (value) => dispositivo.nombre = value,
        validator: (value) {
          if (value.length < 3) {
            return "Ingrese un nombre con formato correcto";
          } else {
            return null;
          }
        },
      ),
    ); */
  }

  Widget _idDispo() {
    return Stack(
      children: <Widget>[_idTexto(), _idFoto()],
      alignment: Alignment.bottomRight,
    );
  }

  Widget _idTexto() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 90, 5),
      child: TextFormField(
        initialValue: dispositivo.id,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Serial del Dispositivo:',
        ),
        onSaved: (value) => dispositivo.id = value,
        validator: (value) {
          if (value.length < 3) {
            return "Ingrese un nombre correcto";
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _idFoto() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 20, 5),
      child: SizedBox(
        height: 55,
        width: 55,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Color.fromRGBO(224, 136, 75, 1),
            textColor: Colors.grey[300],
            elevation: 5.0,
            onPressed: () async{
              id = await FlutterBarcodeScanner.scanBarcode(
                                                    '#ff6666', 
                                                    'Cancel',
                                                    false, 
                                                    ScanMode.QR);

              //FlutterBarcodeScanner.getBarcodeStreamReceiver("#ff6666", "Cancel", false, ScanMode.QR);
              print(id);
            },
            child: Icon(Icons.qr_code_sharp)),
      ),
    );
  }

  /* Este metodo es por si gustas agregar algun Switch pa ponerlo como prendido o apagado;) 
  Widget _crearActivo(){
   return SwitchListTile(
      value: dispositivo.activo,
      title: Text("Disponible"),
      onChanged: (value)=> setState((){
        dispositivo.activo = value;
      }),
    ); 
  } */

  Widget _crearBoton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        height: 50,
        width: 150,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Color.fromRGBO(224, 136, 75, 1),
            textColor: Colors.grey[300],
            elevation: 5.0,
            onPressed: (_guardado) ? null : _cambioPagina,
            child: Text(
              'Guardar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            )),
      ),
    );
  }

  Future _cambioPagina() async {
    
    if( dispositivo.fotoUrl != null){
      if(formKey.currentState.validate()){
        //si sí
        final registro = await _submit();
        Navigator.pushNamed(context, 'homePage');
      }
    }else{mostrarAlerta(context, 'es la foto');}
  }

  void _submit() async{
    if(!formKey.currentState.validate()) {
      mostrarAlerta(context, 'Datos invalidos');
    }  else{
      formKey.currentState.save();
 
      print(dispositivo.nombre);
      if(foto != null){
        dispositivo.fotoUrl =await dispProvider.subirImagenes(foto);  
      }
      
      setState(() { _guardado = true; });

      if(dispositivo.id == '' ){
        dispProvider.crearDispo(dispositivo);
      }
      else{
        dispProvider.editarDispo(dispositivo);
      }

      mostrarSnackbar('Dispositivo guardado correctamente');
      
    }
    //Navigator.pushNamed(context, 'homePage');
  }
  
  void mostrarSnackbar(String mensaje){
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500) ,
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
 