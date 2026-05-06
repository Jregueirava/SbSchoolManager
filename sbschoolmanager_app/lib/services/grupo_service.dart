
import "dart:convert";
import "package:http/http.dart" as http;
import "../config/api_config.dart";
import "../models/grupo.dart";

class GrupoService {

  Future<List<Grupo>> obtenerPorAlumno(int codAlumno) async{

    final response = await http.get(Uri.parse("${ApiConfig.grupos}/alumno/$codAlumno"),
    );

    if(response.statusCode == 200){

      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Grupo.fromJson(json)).toList();
    }
    throw Exception("Error al cargar grupos: ${response.statusCode}");
  }

  Future<Grupo> crear(Grupo grupo) async{
    final response = await http.post(Uri.parse(ApiConfig.grupos),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(grupo.toJson()),
    );

    if(response.statusCode == 200){
      return Grupo.fromJson(jsonDecode(response.body));
    } 
    throw Exception("Error al crear el grupo: ${response.statusCode}");
  }

  Future<void> eliminar(int id) async{
    final response = await http.delete(Uri.parse("{$ApiConfig.grupos}/$id"));

    if(response.statusCode != 204){
      throw Exception("Error al eliminar el grupo: ${response.statusCode}");
    }
  }
}