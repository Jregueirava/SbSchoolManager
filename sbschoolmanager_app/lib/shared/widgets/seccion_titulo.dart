import "package:flutter/material.dart";
import "../../config/app_colors.dart";

class SeccionTitulo extends StatelessWidget{
  final String texto;

  const SeccionTitulo({super.key, required this.texto});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
      texto.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.grisMedio,
        letterSpacing: 0.8,
       ),
     ),
   );
  }
}