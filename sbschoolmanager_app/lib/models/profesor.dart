
class Profesor {
  final int? codProfesor;
  final String nombre;
  final String apellido;
  final String dni;
  final int anosExperiencia;

  Profesor({

    this.codProfesor,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.anosExperiencia,

  });

  factory Profesor.fromJson(Map<String, dynamic> json){

    return Profesor(
      codProfesor: json["codProfesor"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      dni: json["dni"],
      anosExperiencia: json["anosExperiencia"],
      );
  }

  Map<String, dynamic> toJson(){
    return{
      if(codProfesor != null)
        "codProfesor": codProfesor,
        "nombre": nombre,
        "apellido": apellido,
        "dni": dni,
        "anosExperiencia": anosExperiencia,
    };
  }

}