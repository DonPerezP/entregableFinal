// To parse this JSON data, do
//
//     final estudiantes = estudiantesFromJson(jsonString);

import 'dart:convert';

Estudiantes estudiantesFromJson(String str) =>
    Estudiantes.fromJson(json.decode(str));

String estudiantesToJson(Estudiantes data) => json.encode(data.toJson());

class Estudiantes {
  String? id;
  String docIdentidad;
  String nombre;
  String edad;

  Estudiantes({
    this.id,
    required this.docIdentidad,
    required this.nombre,
    required this.edad,
  });

  String toJson() => json.encode(toMap());

  factory Estudiantes.fromJson(Map<String, dynamic> json) => Estudiantes(
        id: json["id"],
        docIdentidad: json["docIdentidad"],
        nombre: json["nombre"],
        edad: json["edad"],
      );

  Map<String, dynamic> toMap() => {
        //"id": id,
        "docIdentidad": docIdentidad,
        "nombre": nombre,
        "edad": edad,
      };
}
