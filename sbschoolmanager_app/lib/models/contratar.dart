
import "alumno.dart";
import "clase_skate.dart";

class Contratar {
  final Alumno alumno;
  final ClaseSkate claseSkate;
  final String fechaInicio;
  final String fechaFin;

  Contratar({
    required this.alumno,
    required this.claseSkate,
    required this.fechaInicio,
    required this.fechaFin,
  });

  factory Contratar.fromJson(Map<String, dynamic> json){
    return Contratar(
      alumno: Alumno.fromJson(json["alumno"]),
      claseSkate: ClaseSkate.fromJson(json["claseSkate"]),
      fechaInicio: json["fechaIncio"],
      fechaFin: json["fechaFin"],
       );
  }

  Map<String, dynamic> toJson(){
    return{
      "alumno": alumno.toJson(),
      "claseSkate": claseSkate.toJson(),
      "fechaInicio": fechaInicio,
      "fechaFin": fechaFin,
    };
  }
}