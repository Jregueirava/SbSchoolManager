
import "dart:io";

import "../config/api_config.dart";
import "../core/network/http_client.dart";
import "../models/material.dart";

class MaterialService {

  final _client = HttpClient();

  Future <List<Material>> obtenerPorAlumno(int codAlumno)async{
    final data = 
      await _client.get("${ApiConfig.materiales}/alumno/$codAlumno");
    return (data as List).map((json) => Material.fromJson(json)).toList();
  }

  Future <List<Material>> obtenerTodos()async{
    final data = await _client.post(ApiConfig.materiales);
    return (data as List).map((json) => Material.fromJson(json)).toList();
  }

  Future <Material> crear(Material material) async{
    final data = await _client.post(ApiConfig.materiales, material.toJson());
    return Material.fromJson(data);
  }

  Future<Material> actualizar(Material material) async{
    final data  = await _client.put(
      "${ApiConfig.materiales}/${material.codMaterial}",
      material.toJson(),
    );
    return Material.fromJson(data);
  }

  Future <void> eliminar(int id) async{
    await _client.delete("${ApiConfig.materiales}/$id");
  }
}