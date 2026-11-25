import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../models/clase_skate.dart";
import "../../services/clase_skate_service.dart";
import "../clases/clase_form_screen.dart";
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

  Future<void> _openProfesorForm() async{
    final created = await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (_) => const ProfesorFormScreen()),
    );

    if(created == true && mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar (content: Text("Profesor creado correctamente")),
      );
    }
  }

  void _openProfesorDetalle(int codProfesor){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProfesorDetalleScreen(codProfesor: codProfesor),
      ),
    );
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.grisFondo;
      appBar: AppBar(
        title: const Text("Clase de skate"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: "Nuevo profesor",
            icon: const Icon(Icons.person_add),
            onPressed: _openProfesorForm,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openClaseForm,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<ClaseSkate>>(
        future: _clasesFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConncectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }

          if(snapshot.hasError){
            return const Center(
              child: Text(
                "Error al cargar las clases",
                style: TextStyle(color: AppColors.grisMedio),
              ),
            );
          }
          final clases = snapshot.data ?? [];

          if(clases.isEmpty){
            return const Center(
              child: Text(
                "Todavía no hay clases",
                style: TextStyle(color: AppColors.grisMedio),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: clases.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index){
              final clase = clases[index];
              return _ClaseCard(
                clase: clase,
                onTap: () => _openProfesorDetalle(clase.codProfesor),
              );
            },
          );
        },
      ),
    );
  }
}

class _ClaseCard extends StatelessWidget{
  const _ClaseCard({required this.clase, required this.onTap});

  final ClaseSkate clase;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context){
    return Card(
      color: AppColors.blanco,
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Icons.skateboarding, color: AppColors.primary),
        title: Text(
          clase.tipoClase,
          style: const TextStyle(
            color: AppColors.grisOscuro,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "${clase.duracion} h · ${clase.tarifa.toStringAsFixed(2)} €",
          style: const TextStyle(color: AppColors.grisMedio),
        ),
        trailing: const Icon(Icons.chevron_rigth),
      ),
    );
  }
}