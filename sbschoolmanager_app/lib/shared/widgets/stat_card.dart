import "package:flutter/material.dart";
import "../../app_color.dart";

class StartCard extends StatelessWidget{
  final IconData icono;
  final Color color;
  final Color iconColor;
  final String valor;
  final String label;

  const StatCard({
      super.key,
      required this.icono,
      required this.color,
      required this.iconColor,
      required this.valor,
      required this.label,
  });

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.blanco,
          borderRadius: BorderRadius.circular(14),
          boxShadow[
            BoxShadow(
              color: AppColors.primary.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0.2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icono, color: iconColor, size: 18),
            ),
            const SizedBox(height: 8),
            Text(
              valor,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.grisOscuro
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.grisMedio,
              ),
            ),
          ],
        ),
      ),
    );
  }
}