
import "clase_skate.dart";

class Horario {

  final int? codHorario;
  final ClaseSkate claseSkate;
  final String dia;
  final String hora;

  Horario({
    this.codHorario,
    required this.claseSkate,
    required this.dia,
    required this.hora,

  });

  factory Horario.fromJson(Map<String, dynamic> json){
    return Horario(
      codHorario: json["codHorario"],
      claseSkate: ClaseSkate.fromJson(json["claseSkate"]),
      dia: json["dia"],
      hora: json["hora"],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      if(codHorario != null) 
      "codHorario": codHorario,
      "claseSkate": claseSkate.toJson(),
      "dia": dia,
      "hora": hora,
    };
  }

}