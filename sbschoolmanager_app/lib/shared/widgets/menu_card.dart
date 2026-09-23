import "package:flutter/material.dart";
import"../../config/app_colors.dart";

class MenuCard extends StatelessWidget{
  final IconData icono;
  final Color color;
  final String titulo;
  final String subtitulo;
  final VoidCallback onTap;


  const MenuCard({
    super.key,
    required this.icono,
    required this.color,
    required this.subtitulo,
    required this.onTap,
  });

  @override
  Widget build (BuildContext context){
    return Card(
      margin: const Edgeinsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 4),
         leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ) ,
          child: Icon(icono, color: AppColors.primary),
        ),
        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.grisOscuro,
          ),
        ),
        subtitle: Text(
          subtitulo,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.grisMedio,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: AppColors.grisClaro,
        ),
        onTap: onTap,
      ),
    );
  }
}