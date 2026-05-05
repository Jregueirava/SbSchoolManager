
import "alumno.dart";

class Material {

  final int? codMaterial;
  final Alumno alumno;
  final String tipoMaterial;
  final double precio;
  final int tiempo;

  Material({
    this.codMaterial,
    required this.alumno,
    required this.tipoMaterial,
    required this.precio,
    required this.tiempo,
  });

  factory Material.fromJson(Map<String, dynamic> json){
    return Material(
      codMaterial: json["codMaterial"],
      alumno: Alumno.fromJson(json["alumno"]),
      tipoMaterial: json["tipoMaterial"],
      precio: (json["precio"] as num).toDouble(),
      tiempo: json["tiempo"],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      if(codMaterial != null)
      "codMaterial": codMaterial,
      "alumno": alumno.toJson(),
      "tipoMaterial": tipoMaterial,
      "precio": precio,
      "tiempo": tiempo,
    };
    
  }
}