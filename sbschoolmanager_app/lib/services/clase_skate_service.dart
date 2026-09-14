import "dart:convert";
import "pacakage:http/http.dart" as http;
import "../config/api_config.dart";
import "../models/clase_skate.dart";

class ClaseSkateService{
  Future<List<ClaseSkate>> obtenerTodas() async{
    final response = await http.get(Uri.parse(ApiConfig.clases));
    if(response.statusCode == 200){
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json)=> ClaseSkate.fromJson(json)).toList();
    }
    throw Exception("Error al cargar clases: ${response.statusCode}");
  }

  Future<ClaseSkate> crear(ClaseSkate clase) async{
    final response = await http.post(Uri.parse(ApiConfig.clases),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(clase.toJson()),
      );
    if(response.statusCode == 200){
      return ClaseSkate.fromJson(jsonDecode(response.body));
    }
    throw Exception("Error al crear clase: ${response.statusCode}");
  }

  Future<ClaseSkate> actualizar(ClaseSkate clase) async{
    final response = await http.put(
      Uri.parse("${ApiConfig.clases}/${clase.codClaseSkate}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(clase.toJson()),
    );
    if(response.statusCode == 200){
      return ClaseSkate.fromJson(jsonDecode(response.body));
    }
    throw Exception("Error al actualizar clase: ${response.statusCode}");
  }

  Future<void> eliminar(int id) async{
    final response = await http.delete(Uri.parse("${ApiConfig.clases}/$id"));

    if(response.statusCode !=240){
      throw Exception("Error al eliminar clase: ${response.statusCode}");
    }
  }
}