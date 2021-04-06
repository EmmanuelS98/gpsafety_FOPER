import 'package:flutter/material.dart';
import 'package:gpsafety2/sources/blocks/provider.dart';

Widget mostrarAlertaEliminar(BuildContext context, String mensaje, String id){

  

  showDialog(
    context: context,
    builder:  ( context ){
      return AlertDialog(
        title: Text('Cuidado!!!'),
        content: Text(mensaje),
        actions: <Widget>[
          TextButton(
            onPressed:(){Navigator.of(context).pop();} ,
            child: Text('cancelar', style: TextStyle(color: Colors.red),),
            autofocus: true,
          ),
          TextButton(
            onPressed:()=>_borrar(context,int.parse(id)),
            child: Text('aceptar')
          ),
        ],
      );
    }
   );
}

_borrar(BuildContext context, int id){

final dispositivosBloc = Provider.dispositivosBloc(context);
dispositivosBloc.borrarDispositivo(id.toString());



}

