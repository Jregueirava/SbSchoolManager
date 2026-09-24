import "package:flutter/material.dart";
import "../config/app_colors.dart";
import "../models/horario.dart";
import "../services/alumno_service.dart";
import "../services/profesor_service.dart";
import "../services/clase_skate_service.dart";
import "../services/horario_service.dart";
import "../shared/widgets/stat_chip.dart";
import "../shared/widgets/menu_card.dart";
import "../shared/widgets/horario_hoy_card.dart";
import "alumnos/alumno_list_screen.dart";
import "profesores/profesor_list_screen.dart";
import "clases/clase_list_screen.dart";
import "materiales/material_list_screen.dart";

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override 
  State<HomeScreen> createState() => _HomeScreenState();

  
}