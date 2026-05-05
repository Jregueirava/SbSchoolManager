
class Alumno {
  final int? codAlumno; //El id lo asigna la BD
  final String nombre;
  final String apellido;
  final String dni;
  final int edad;
  final String? datosPadres;

  Alumno({
      this.codAlumno,
      required this.nombre,
      required this.apellido,
      required this.dni,
      required this.edad,
      this.datosPadres,
  });

  //Json de Spring -> objeto Alumno
  factory Alumno.fromJson(Map<String, dynamic> json){
    return Alumno(
      codAlumno: json["codAlumno"],
      nombre: json["nombre"], 
      apellido: json["apellido"],
      dni: json["dni"], 
      edad: json["edad"],
      datosPadres: json["datosPadres"],
      );
  }

  //Objeto Alumno -> JSON
  Map<String, dynamic> toJson(){
    return{
      if(codAlumno != null)
      "codAlumno": codAlumno,
      "nombre": nombre,
      "apellido": apellido,
      "dni": dni,
      "edad": edad,
      "datosPadres": datosPadres,
    };
  }
}