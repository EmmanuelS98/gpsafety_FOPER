import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String id;
    String nombre;
    String mail;
    String password;
    String fotoUrl;
    String dispositivos;


   
    UserModel({
        this.id = '',
        this.nombre ='predeterminado',
        this.mail = 'predeterminado',
        this.password = '',
        this.fotoUrl='predeterminado',
        this.dispositivos='',
    });

    

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id        : json["id"],
        nombre    : json["nombre"],
        mail      : json["activo"],
        password  : json["password"],
        fotoUrl   : json["fotoUrl"] ,
        dispositivos   : json["dispositivos"] 
    );

    Map<String, dynamic> toJson() => {
        "id"      : id,
        "nombre"  : nombre,
        "email"  : mail,
        "password"  : password,
        "fotoUrl" : fotoUrl,
        "dispositivos" : dispositivos,
    };
}
