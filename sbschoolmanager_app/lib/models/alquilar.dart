
import "alumno.dart";
import "material.dart";

class Alquilar{
  final Alumno alumno;
  final Material material;
  final String fechaInicio;
  final String fechaFin;

  Alquilar({
    required this.alumno,
    required this.material,
    required this.fechaInicio,
    required this.fechaFin,
  });

  factory Alquilar.fromJson(Map<String, dynamic> json){
    return Alquilar(
      alumno: Alumno.fromJson(json["alumno"]),
      material: Material.fromJson(json["material"]),
      fechaInicio: json["fechaInicio"],
      fechaFin: json["fechaFin"],
    );
  }

  Map<String , dynamic> toJson(){
    return{
      "alumno": alumno.toJson(),
      "material": material.toJson(),
      "fechaInicio": fechaInicio,
      "fechaFin": fechaFin,
    };
  }
}