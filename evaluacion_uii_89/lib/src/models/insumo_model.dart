import 'dart:convert';

Insumo materialFromJson(String str) => Insumo.fromJson(json.decode(str));

String materialToJson(Insumo data) => json.encode(data.toJson());

class Insumo {
  Insumo(
      {this.id,
      required this.tipo,
      required this.nombre,
      required this.descripcion});

  int? id;
  int tipo;
  String nombre;
  String descripcion;

  factory Insumo.fromJson(Map<String, dynamic> json) => Insumo(
      id: json["id"],
      tipo: json["tipo"] as int,
      nombre: json["nombre"],
      descripcion: json["descripcion"]);

  factory Insumo.created() => Insumo(tipo: 0, nombre: "", descripcion: "");

  Map<String, dynamic> toJson() =>
      {"id": id, "tipo": tipo, "nombre": nombre, "descripcion": descripcion};
}