import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';

import 'package:gpsafety2/sources/models/dispositivosModel.dart';
import 'package:gpsafety2/sources/providers/dispositivosProvider.dart';


class DispositivoBloc{

  final _dispositivosController = new BehaviorSubject<List<DispositivoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();
  
  final _dispositivosProvider = new DispositivosProvider();

  Stream<List<DispositivoModel>> get dispositivosStream => _dispositivosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarDispositivos(BuildContext context) async{
    final dispositivos = await _dispositivosProvider.cargarDispositivos(context);
    _dispositivosController.sink.add( dispositivos );
  }

  void agregadDispositivos( DispositivoModel dispositivo )async{
    _cargandoController.sink.add(true);
    await _dispositivosProvider.crearDispo(dispositivo);
    _cargandoController.sink.add(false);
  }

  Future<String> subirFoto( File foto )async{
    _cargandoController.sink.add(true);
    final  fotoUrl = await _dispositivosProvider.subirImagenes(foto);
    _cargandoController.sink.add(false);

    return fotoUrl; 
  }

  void editarDispositivo( DispositivoModel dispositivo )async{
    _cargandoController.sink.add(true);
    await _dispositivosProvider.editarDispo(dispositivo);
    _cargandoController.sink.add(false);
  }

  void borrarDispositivo(String id) async{
    await _dispositivosProvider.borrarDispositivo(id);
  } 


  dispose(){
    _dispositivosController?.close();
    _cargandoController?.close();
  }
}