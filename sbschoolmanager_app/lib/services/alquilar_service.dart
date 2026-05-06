
import "dart:io";

import "../config/api_config.dart";
import "../core/network/http_client.dart";
import "../models/alquilar.dart";

class AlquilarService {

  final _client= HttpClient();

  Future<List<Alquilar>> obtenerPorAlumno(int codAlumno) async{
    final data = await _client.get("${ApiConfig.alquileres}/alumno/$codAlumno");
    return (data as List).map((json) => Alquilar.fromJson(json)).toList();
  }

  Future<Alquilar> crear (Alquilar alquilar) async{
    final data = await _client.post(ApiConfig.alquileres, alquilar.toJson());
    return Alquilar.fromJson(data);
  }
}