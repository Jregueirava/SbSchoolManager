
import "package:flutter/material.dart";
import "../errors/app_exception.dart";

//Centralizción de lógica para no repetir en las pantallas

mixin ErrorHandlerMixin< T extends StatefulWidget> on State<T> {

  bool guradando = false;

  //Ejecuta una operación asíncrona mostrando un spinner y capturando cualquier error con un SnackBar

  Future<void> ejecutarConManejo(Future<void> Function()operacion, {
    String mensajeExito = "Guardado  correctamente", 
  }) async{
    setState(() => guardando = true);
    try{
      await operacion();
      if(mounted){
        _mostrarExito(mensajeExito);
        Navigator.pop(context);
      }
    } on NetworkException catch(e){
      if(mounted) _mostrarError(e.mensaje, icono: Icons.wifi_off);
    } on ValidationException catch(e){
      if(mounted) _mostrarError(e.mensaje, icono: Icons.warning_amber);
    } on ServerException catch(e){
      if (mounted) _mostrarError(e.mensaje, icono: Icons.cloud_off);
    } on AppException catch(e){
      if(mounted) _mostrarError(e.mensaje);
    } finally{
      if(mounted) setState(() => guardando = false);
    }
  }


  void _mostrarExito(String mensaje){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children:[
          const Icon(Icons.check_circle, color: Colors.white),
          const SizedBox(width: 8),
          Text(mensaje),
        ]),
        backgroundColor:Colors.green,
        duration: const Duration(seconds:2),
      ),
    );
  }

  void _mostrarError(String mensaje, {IconData icono = Icons.error_outline}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: 
        [
          Icon(icono, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(mensaje)),

        ]),
        backgroundColor: Colors.red,
        duration: const Duration(seconds:4),
        action: SnackBarAction(
          label: "Ok",
          textColor:Colors.white,
          onPressed: ()=> 
            ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }
}