import 'package:flutter/material.dart';


import 'package:gpsafety2/sources/blocks/login_bloc.dart';
export 'package:gpsafety2/sources/blocks/login_bloc.dart';

import 'package:gpsafety2/sources/blocks/dispositivos_bloc.dart';
export 'package:gpsafety2/sources/blocks/dispositivos_bloc.dart';





//se hace uso del inheritedWidget que sera el encargado de notificar a el widget padre de posibles cambios
class Provider extends InheritedWidget{
  
  final loginBloc = LoginBloc();
  final _dispositivosBloc = DispositivoBloc();
  
  static Provider _instancia;
  
  factory Provider( {Key key, Widget child }){
    if(_instancia == null ){
      _instancia = new Provider._internal(key: key, child: child );
    }
    return _instancia;
  }
  
  Provider._internal({ Key key, Widget child })
    :super(key: key, child: child );

  
  //Provider({ Key key, Widget child })
  //  :super(key: key, child: child);
    

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  } 

  static DispositivoBloc dispositivosBloc (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._dispositivosBloc;
  }
}