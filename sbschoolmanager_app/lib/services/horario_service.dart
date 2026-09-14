import "dart:convert";
import "package:http/http.dart" as http;
import "../config/api_config.dart";
import "../models/horario.dart";

class HorarioService {
  Future <List<Horario>> obtenerPorClase(int codClase) async {
    final response = await http.get(
      Uri.parse("${ApiConfig.horario}/clase/$codClase"),
    );
  }
}