import "package:flutter/material.dart";
import "app_colors.dart";

// Niveles disponibles para un grupo de la escuela y sus colores

class NivelesGrupo{
  const NivelesGrupo._();

  static const List<String> todos = [
    "Principiante",
    "Intermedio",
    "Avanzado",
  ];

  // Color iconos y texto
  static Color colorDe(String nivel){
    return switch (nivel){
      "Principiante" => AppColors.principiante,
      "Intermedio" => AppColors.intermedio,
      "Avanzado" => AppColors.avanzado,
      _ => AppColors.grisMedio,
    };
  }

  // Color de fondo
  static Color colorSuaveDe(String nivel){
    return switch (nivel){
      "Principiante" => AppColors.principianteSuave,
      "Intermedio" => AppColors.intermedioSuave,
      "Avanzado" => AppColors.avanzadoSuave,
      _ => AppColors.grisSuave,
    };
  }
}