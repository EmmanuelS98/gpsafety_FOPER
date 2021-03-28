import 'dart:convert';

DispositivoModel dispositivoModelFromJson(String str) => DispositivoModel.fromJson(json.decode(str));

String dispositivoModelToJson(DispositivoModel data) => json.encode(data.toJson());

class DispositivoModel {
    String id;
    String nombre;
    bool activo;
    String fotoUrl;

   
    DispositivoModel({
        this.id = '',
        this.nombre ='',
        this.activo = false,
        this.fotoUrl,
    });

    

    factory DispositivoModel.fromJson(Map<String, dynamic> json) => DispositivoModel(
        id      : json["id"],
        nombre  : json["nombre"],
        activo  : json["activo"],
        fotoUrl : json["fotoUrl"] 
    );

    Map<String, dynamic> toJson() => {
        "id"      : id,
        "nombre"  : nombre,
        "activo"  : activo,
        "fotoUrl" : fotoUrl,
    };
}
