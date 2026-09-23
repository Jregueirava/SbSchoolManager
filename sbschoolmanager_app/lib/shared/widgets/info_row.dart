import "package:flutter/material.dart";
import "../../config/app_colors.dart";

class infoRow extends StatelessWidget{
  final IconData icono;
  final String label;
  final String valor;
  final Color iconColor;

  const InfoRow({
    super.key,
    required this.icono,
    required this.label,
    required this.valor,
    this.iconColor = AppColors.primary,
  });

  @override
  Widget build (BuildContext context){
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icono, color: iconColor, size: 18),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: AppColors.grisMedio,
        ),
      ),
      subtitle: Text(
        valor,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.grisOscuro,
        ),
      ),
    );
  }
}