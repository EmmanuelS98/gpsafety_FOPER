import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpsafety2/sources/models/dispositivosModel.dart';
import 'package:gpsafety2/sources/user_preferences/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class DispositivosProvider{
  final String _url = 'https://foperuaq2021-default-rtdb.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<String> inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }


  Future <bool> crearDispo( DispositivoModel dispositivo  )async{

    var user = inputData();

    print(user);
    
    
//    final url = '$_url/usuarios/$dispo/dispositivos.json?auth=${_prefs.token}';
    final url = '$_url/dispositivos.json?auth=${_prefs.token}';
    final resp = await http.post(url, body: dispositivoModelToJson(dispositivo));
    final decodedData = json.decode(resp.body);

    print("$decodedData is here ");
    
    return true;
  }

  Future <bool> editarDispo( DispositivoModel dispositivo  )async{

    final url = '$_url/dispositivos/${dispositivo.id}.json?auth=${_prefs.token}';
    final resp = await http.put(url, body: dispositivoModelToJson(dispositivo));
    final decodedData = json.decode(resp.body);

    print("$decodedData is here ");
    
    return true;
  }

  Future <int> borrarDispositivo(String id) async{
    final url = '$_url/dispositivos/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));

    return 0;
  }

  Future <List<DispositivoModel>> cargarDispositivos(BuildContext context)async{
    final url = '$_url/dispositivos.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String,dynamic>  decodedData = json.decode(resp.body);
    final List<DispositivoModel> dispositivos = new List();
   
    
    if(decodedData == null) return[];
    
    if(decodedData['error'] != null ) {
      return Navigator.pushReplacementNamed(context, 'registro');
    }

    decodedData.forEach((id, dispositivo) {
        final dispTemp = DispositivoModel.fromJson(dispositivo);
        dispTemp.id = id;

        dispositivos.add(dispTemp);


     }); 

    print(dispositivos);

    return dispositivos;
  }

  Future<String> subirImagenes(File image) async{
    final url = Uri.parse('https://api.cloudinary.com/v1_1/degxfsj5c/image/upload?upload_preset=ny5kabck');
    final mimeType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );


    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(mimeType[0], mimeType[1])
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201){
      print('Algo salio mal');
      print(resp.body);
      return null;
    }
    
    final respData = json.decode(resp.body);
    print(respData); 


    return respData['secure_url'];

  }
}