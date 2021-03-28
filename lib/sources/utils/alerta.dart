import 'package:flutter/material.dart';

void mostrarAlerta(BuildContext context, String mensaje){
  showDialog(
    context: context,
    builder:  ( context ){
      return AlertDialog(
        title: Text('Informacion incorrecta'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            onPressed: ()=>Navigator.of(context).pop(),
            child: Text('Ok'))
        ],
      );
    }
   );
}