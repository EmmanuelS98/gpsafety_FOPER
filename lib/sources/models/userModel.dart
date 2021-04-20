import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String id;
    String nombre;
    String mail;
    String password;
    String fotoUrl;

   
    UserModel({
        this.id = '',
        this.nombre ='',
        this.mail = '',
        this.password = '',
        this.fotoUrl,
    });

    

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id        : json["id"],
        nombre    : json["nombre"],
        mail      : json["activo"],
        password  : json["password"],
        fotoUrl   : json["fotoUrl"] 
    );

    Map<String, dynamic> toJson() => {
        "id"      : id,
        "nombre"  : nombre,
        "activo"  : mail,
        "password"  : password,
        "fotoUrl" : fotoUrl,
    };
}
