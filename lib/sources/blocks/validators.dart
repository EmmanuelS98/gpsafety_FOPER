import 'dart:async';

import 'package:flutter/material.dart';

class Validators{
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if( password.length >= 6 ){
        sink.add(password);
      }
      else{
        sink.addError('Mas de 6 caracteres por favor');
      }
    }
  );

  final validarNombre = StreamTransformer<String, String>.fromHandlers(
    handleData: (nombre, sink){
      if( nombre.length >= 3 ){
        sink.add(nombre);
      }
      else{
        sink.addError('Formato no Valido');
      }
    }
  );

  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      
       Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
       RegExp regExp = new RegExp(pattern);

       if( regExp.hasMatch(email)){
          sink.add(email);
       }
       else{
         sink.addError('Correo no valido');
       }

    }
  );
}

