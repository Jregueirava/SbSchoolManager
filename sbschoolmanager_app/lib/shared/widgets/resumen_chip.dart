import "package:flutter/material.dart";
import "../../config/app_colors.dart";

class ResumenChip extends StatelessWidget{
  final int valor;
  final String label;
  final Color color;

  
  const ResumenChip({
    super.key,
    required this.valor,
    required this.label,
    required this.color,

  });

  @override
  Widget build (BuildContext context){
    return Expanded(
      child: Container(
        padding: cosnt EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.blanco,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
       child: Column(
        children: [
          Text(
            "$valor",
            style: TextStyle(

              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.grisMedio,
            ),
          ),
        ],
       ) ,
      ),
    );
  }
}