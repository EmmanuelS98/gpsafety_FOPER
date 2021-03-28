import 'dart:async';
import 'package:gpsafety2/sources/blocks/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //RECUPERAR DATOS DEL STREAM
  Stream<String> get emailStream =>_emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>_passwordController.stream.transform(validarPassword);

  

  Stream<bool> get formValidStream =>
    Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  //obtener ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }
}