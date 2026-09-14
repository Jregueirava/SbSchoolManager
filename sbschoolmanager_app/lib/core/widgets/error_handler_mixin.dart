
import "package:flutter/material.dart";
import "../errors/app_exception.dart";

//Centralizción de lógica para no repetir en las pantallas

mixin ErrorHandlerMixin< T extends StatefulWidget> on State<T> {

  bool guradando = false;

  
}