
import "alumno.dart";

class Grupo {
  final int? codGrupo;
  final Alumno alumno;
  final String nivel; 


  Grupo({

    this.codGrupo,
    required this.alumno,
    required this.nivel,

  });

  factory Grupo.fromJson(Map< String, dynamic> json){
    return Grupo(
      codGrupo: json["codGrupo"],
      alumno: Alumno.fromJson(json["alumno"]), 
      nivel: json["nivel"],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      if(codGrupo != null)
      "codGrupo": codGrupo,
      "alumno": alumno.toJson(),
      "nivel": nivel,
    };
  }
}