
import "dart:convert";
import "package:http/http.dart" as http;
import "../config/api_config.dart";
import "../models/profesor.dart";

class ProfesorService {

  Future<List<Profesor>> obtenerTodos() async{
    final response = await http.get(Uri.parse(ApiConfig.profesores));

    if(response.statusCode == 200){
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Profesor.fromJson(json)).toList();
    } else{
        throw Exception("Error al cargar profesores: ${response.statusCode}");
    }
  }

  Future <Profesor> crear(Profesor profesor) async{
    final response = await http.post(Uri.parse(ApiConfig.profesores),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(profesor.toJson()),
    );

    if(response.statusCode == 200){
      return Profesor.fromJson(jsonDecode(response.body));
    } else{
      throw Exception("Error al crear profesor: ${response.statusCode}");
    }
  }

  Future <void> eliminar(int id) async{
    final response = await http.delete(Uri.parse("${ApiConfig.profesores}/$id"),
    );

    if(response.statusCode != 204){
      throw Exception("Error al eliminar profesor: ${response.statusCode}");
    }
  }
}