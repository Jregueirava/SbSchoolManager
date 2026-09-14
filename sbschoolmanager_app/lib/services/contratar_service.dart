import "../config/api_config.dart";
import "../core/network/http_client.dart";
import "../models/contratar.dart";


//Tabla intermedia con clave compuesta por eso no tiene ni eliminar ni actualizar.
class ContratarService{
  final _client = HttpClient();

  Future<List<Contratar>> obtenerTodos() async{
    final data = await _client.get(ApiConfig.contrataciones);
    return (data as List)
          .map((json) => Contratar.fromJson(json))
          .toList();
  }

  Future<List<Contratar>> obtenerPorAlumno(int codAlumno) async{
    final data = await _client.get(
      "${ApiConfig.contrataciones}/alumno/$codAlumno",
    );
    return (data as List) 
          .map((json) => Contratar.fromJson(json))
          .toList();
  }

  Future<List<Contratar>> obtenerPorClase(int codClaseSkate) async {
    final data = await _client.get(
      "${ApiConfig.contrataciones}/clase/$codClaseSkate",
    );
    return (data as List)
            .map((json) => Contratar.fromJson(json))
            .toList();
  }

  Future<Contratar> crear (Contratar contratar) async {
    final data = await _client.post(
      ApiConfig.contrataciones,
      contratar.toJson(),
    );
    return Contratar.fromJson(data);
  }
}