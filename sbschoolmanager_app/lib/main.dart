import 'package:flutter/material.dart';
import "config/app_colors.dart";
import "screens/home_screen.dart";

void main() {
  runApp(const SbChoolManagerApp());
}

class SbSchoolManagerApp extends StatelessWidget{
  const SbSchoolManagerApp({super.key});

  @override
  Widget build (BuildContext context){
    return MaterialAPP(
      title: "SbSchoolManager",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.primaryLight,
          surface: AppColors.blanco,
          surfaceContainerHighest: AppColors.grisSuave,
          onPrimary: AppColors.blanco,
          onSecondary: AppColors.blanco,
          onSurface: AppColors.grisOscuro,
        ),
        scaffoldBackgroundColor: AppColors.grisFondo,
        //AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.blanco,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: AppColors.blanco,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          inconTheme: IconThemeData(color: AppColors.blanco),
        ),
        //Cards
        cardTheme: CardThemeData(
          color: AppColors.blanco,
          elevation: 2,
          shadowColor: Color(0x1A1A237E),
          shape: RoundedRectangleBorder(
            borderRadius: _BorderRadius.circular(14),
          ),
          margin: EdgeInsets.zero,
        ),
        // Botones elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.blanco,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fonstSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          //Botones outlined
          outlinedButtonTheme: OutLinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 14
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          //FloattingActionButton
          floatingActionButtonTheme: const floatingActionButtonThemeData(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.blanco,
            elevation: 4,
          ),
          //Inputs
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.blanco,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.grisClaro),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary, width: 2),
              ),
              labelStyle: const TextStyle(color: AppColors.grisMedio),
              prefixIconColor: AppColors.grisMedio,
            ),

            //NavigatonBar
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: AppColors.blanco,
              indicatorColor: AppColors.primarySoft,
              labelTextStyle: WidgetStateProperty.resolveWith((states){
                if(states.contains(WidgetState.selected)){
                  return const TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  );
                }
                return const TextStyle(
                  color: AppColors.grisMedio,
                  fontSize: 11,
                );
              }),
              iconTheme: WidgetStateProperty.resolveWith((states){
                if(states.contains(WidgetState.selected)){
                  return const IconThemeData(color: AppColors.primary);
                }
                return const IconThemeData(color: AppColors.grisMedio);
              }),
            ) ,
            //Chips

            chipTheme: ChipThemeData(
              backgroundColor: AppColors.grisSuave,
              selectedColor: AppColors.primary,
              labelStyle: const TextStyle(fontSize: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            // Divider
            dividerTheme: const DividerThemeData(
            color: AppColors.grisSuave,
            thickness: 1,
            ),

            //Textos
            textTheme: const TextTheme(
              headlineMedium: TextStyle(
                color: AppColors.grisOscuro,
                fontSize: 22,
                fontWeigth: FontWeigth.bold,
              ),
              titleLarge: TextStyle(
                color: AppColors: grisOscuro,
                fontSize: 16,
                fontweigth: FontWeigth.w600, 
              ),
               titleMedium: TextStyle(
                color: AppColors.grisOscuro,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              bodyMedium: TextStyle(
                color: AppColors.grisOscuro,
                fontSize: 13,
              ),
              bodySmall: TextStyle(
               color: AppColors.grisMedio,
              fontSize: 11,
           ),
         ),
       ),
      home: const HomeScreen(),
    );
  }
}

