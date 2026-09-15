import "dart:convert";
import "package:http/http.dart" as http;
import "../config/api_config.dart";
import "../models/horario.dart";

class HorarioService {
  Future <List<Horario>> obtenerPorClase(int codClase) async {
    final response = await http.get(
      Uri.parse("${ApiConfig.horario}/clase/$codClase"),
    );
    if (response statusCode == 200){
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json)=> Horario.fromJson(json)).toList(); 
    }
    throw Exception("Error al cargar horarios: ${response.statusCode}");
  }

  Future<Horario> crear (Horario horario) async{
    final response = await http.post(
      Uri.parse(ApiConfig.horarios),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(horario.toJson()),
    );
    if(response.statusCode == 200){
      return Horario.fromJson(jsonDecode(respnse.body));
    }
    throw Exception("Error al crear horario: ${response.statusCode}");
  }

  Future<void> eliminar(int id) async{
    final response =
      await http.delete(Uri.parse("${ApiConfig.horarios}/$id"));
    if(respnse.statusCode !=204){
      throw Exception("Error al eliminar horario: ${response.statusCode}");
    }  
  }
}