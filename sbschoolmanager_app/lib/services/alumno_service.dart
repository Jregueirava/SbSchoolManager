
import "dart:convert";
import "package:http/http.dart" as http;
import "../config/api_config.dart";
import "../models/alumno.dart";

class AlumnoService {

  //Todos los alumnos. GET /api/alumnos

  Future<List<Alumno>>obtenerTodos()async{
    final response = await http.get(Uri.parse(ApiConfig.alumnos));

    if(response.statusCode == 200){
      final List<dynamic>jsonList = jsonDecode(response.body);
      return jsonList.map((json)=> Alumno.fromJson(json)).toList();
    } else{
      throw Exception("Error al cargar los alumnos: ${response.statusCode}");
    }
  }

  //Crear los alumnos. POST /api/alumnos

  Future<Alumno>crear(Alumno alumno) async{
    final response = await http.post(Uri.parse(ApiConfig.alumnos),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(alumno.toJson()),
    );

    if(response.statusCode == 200){
      return Alumno.fromJson(jsonDecode(response.body));
    } else{
      throw Exception("Error al crear alumno: ${response.statusCode}");
    }
  }

  //Actulizar los alumnos. PUT /api/alumnos/{id}

  Future<Alumno> actualizar(Alumno alumno) async{
    final response = await http.put(Uri.parse("${ApiConfig.alumnos}/${alumno.codAlumno}"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(alumno.toJson()),
    );

    if(response.statusCode == 200){
      return Alumno.fromJson(jsonDecode(response.body));
    } else{
      throw Exception("Error al actulizar el alumno: ${response.statusCode}");
    }
  }

  //Eliminar alumnos. DELETE /api/alumnos/{id}

  Future<void> eliminar(int id) async{
    final response = await http.delete(
      Uri.parse("${ApiConfig.alumnos}/$id"),
    );

    if(response.statusCode !=204){
      throw Exception("Error al eliminar alumno: ${response.statusCode}");
    }
  }

}