
//Clase base de la que van a heredar todos los errores

abstract class AppException implements Exception{

  final String mensaje;
  const AppException(this.mensaje);

  @override
  String toString() => mensaje;
}

//El servidor devuelve un error
class ServerException extends AppException{
  final int statusCode;
  const ServerException(this.statusCode)
    :super("Error del servidor (código $statusCode)");
}

//Si no hay conexión a internet o el sevidor no responde
class NetworkException extends AppException{
  const NetworkException()
    :super("Sin conexión. Comprueba tu red e inténtalo otra vez.");
}

//El recurso no existe(404)
class NotFoundException extends AppException{
  const NotFoundException(String recurso)
    :super("No se encontró: $recurso");
}

//Error de validación(400)
class ValidationException extends AppException{
  const ValidationException(String detalle)
    :super("Datos incorrectos: $detalle");
}