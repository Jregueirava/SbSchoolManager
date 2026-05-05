
import "profesor.dart";

class ClaseSkate {

  final int? codClaseSkate;
  final Profesor profesor;
  final String tipoClase;
  final double tarifa;

  ClaseSkate({
    
    this.codClaseSkate,
    required this.profesor,
    required this.tipoClase,
    required this.tarifa,

  });

  factory ClaseSkate.fromJson(Map<String, dynamic> json){
    return ClaseSkate(
      codClaseSkate: json["codClaseSkate"],
      profesor: Profesor.fromJson(json["profesor"]), //Porque Spring Boot lo devuelve anidado dentro del Json
      tipoClase: json["tipoClase"],
      tarifa: (json["tarifa"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson(){
    return{
      if(codClaseSkate != null)
      "codClaseSkate": codClaseSkate,
      "profesor": profesor.toJson(),
      "tipoClase": tipoClase,
      "tarifa": tarifa,
    };
  }
}