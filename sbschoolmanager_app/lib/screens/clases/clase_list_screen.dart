import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../models/clase_skate.dart";
import "../../services/clase_skate_service.dart";
import "clase_form_screen.dart";
import "../profesores/profesor_detalle_screen.dart";
import "../profesores/profesor_form_screen.dart";

class ClaseListScreen extends StatefulWidget{
  const ClaseListScreen({super.key});

  @override
  State<ClaseListScreen> createState() => _ClaseListScreenState();
}

class _ClaseListScreenState extends State<ClaseListScreen>{
  final _claseService = ClaseSkateService();
  late Future<List<ClaseSkate>> _clasesFuture;

  @override
  void initState(){
    super.initState();
    _clasesFuture = _claseService.obtenerTodas();
  }
  void _realoadClases(){
    setState((){
      _clasesFuture = _claseService.obtenerTodas();
    });
  }

  
}