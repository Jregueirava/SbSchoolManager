
//Desarrollo, Spring Boot corre en local, en Android emulador se usa 10.0.2.2 en vez de localhost.
//En dispositivo físico tiene que ser la ip del ordeandor.
class ApiConfig{
  
  static const String baseUrl= "http://10.0.2.2:8080/api";

  static const String alumnos = "$baseUrl/alumnos";
  static const String profesores = "$baseUrl/profesores";
  static const String materias = "$baseUrl/materias";
  static const String clases = "$baseUrl/clases";
  static const String horarios= "$baseUrl/horarios";
  static const String grupos = "$baseUrl/grupos";
  static const String materiales= "$baseUrl/materiales";
  static const String alquileres= "$baseUrl/alquileres";
  static const String contrataciones= "$baseUrl/contrataciones";
  
}