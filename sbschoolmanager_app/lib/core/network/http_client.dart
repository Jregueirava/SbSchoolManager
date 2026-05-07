
import "dart:async";
import "dart:convert";
import "dart:io";
import "package:http/http.dart" as http;
import "../errors/app_exception.dart";

class HttpClient {
  //Tiempo max espera para respuesta del servidor
  static const Duration _timeout = Duration(seconds: 10);

  //Cabeceras comunes a todas las peticiones
  static const Map<String, String> _headers={
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  //GET
  Future<dynamic>get(String url)async{
    try{
    final response = await http.get(Uri.parse(url), headers: _headers).timeout(_timeout);
    return _procesarRespuesta(response);
  }on SocketException{
    throw const NetworkException();
  } on TimeoutException{
    throw const NetworkException();
  }
  }

  //POST
  Future<dynamic> post(String url, Map<String, dynamic>body)async{
    try{
      final response = await http.post(Uri.parse(url), headers: _headers, body: jsonEncode(body)).timeout(_timeout);
      return _procesarRespuesta(response);
    } on SocketException{
      throw const NetworkException();
    } on TimeoutException{
      throw const NetworkException();
    }
  }

  //PUT
  Future<dynamic> put(String url, Map<String, dynamic>body) async{
    try{
      final response = await http.put(Uri.parse(url), headers: _headers, body: jsonEncode(body)).timeout(_timeout);
      return _procesarRespuesta(response);
    } on SocketException{
      throw const NetworkException();
    } on TimeoutException{
      throw const NetworkException();
    }
  }

  //DELETE
  Future<void> delete(String url) async{
    try{
      final response = await http.delete(Uri.parse(url), headers: _headers).timeout(_timeout);
      if(response.statusCode !=204){
        _procesarRespuesta(response);
      }
    } on SocketException{
      throw const NetworkException();
    } on TimeoutException{
      throw const NetworkException();
    }
  }

  //Procesado de la respuesta y lanzmiento de error según código HTTP

  dynamic _procesarRespuesta(http.Response response){
    switch(response.statusCode){
      case 200:
      case 201:
      return jsonDecode(response.body);
      case 400: 
      throw ValidationException(response.body);
      case 404:
      throw const NotFoundException("recurso no encontrado");
      case 500:
      default:
      throw ServerException(response.statusCode);
    }
  }
}
