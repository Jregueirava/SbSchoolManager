import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../models/clase_skate.dart";
import "../../services/clase_skate_service.dart";
import "../clases/clase_form_screen.dart";
import "../profesores/profesor_detalle_screen.dart";
import "../profesores/profesor_form_screen.dart";
import "../horarios/horario_list_screen.dart";

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

  Future<void> _openClaseForm() async{
    final created = await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (_) => const ClaseFormScreen()),
    );
    if(created == true){
      _realoadClases();
    }
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

  void _openHorarios(ClaseSkate clase){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HorarioListScreen(claseSkate: clase),
      ),
    );
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
      backgroundColor: AppColors.grisFondo,
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
          if(snapshot.connectionState == ConnectionState.waiting){
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
                onTap: () => _openHorarios(clase),
                onProfesorTap: () => _openProfesorDetalle(clase),
              );
            },
          );
        },
      ),
    );
  }
}

class _ClaseCard extends StatelessWidget{
  const _ClaseCard({required this.clase, required this.onTap, required this.onProfesorTap,});

  final ClaseSkate clase;
  final VoidCallback onTap;
  final VoidCallback onProfesorTap;

  @override
  Widget build(BuildContext context){
    final profesor = clase.profesor;
    
    return Card(
      color: AppColors.blanco,
      child: ListTile(
       onTap: onTap,
       leading: const CircleAvatar(
        backgroundColor: AppColors.primarySoft,
        child: Icon(Icons.skateboarding, color: AppColors.primary),
       ),
       title: Text(
        clase.tipoClase,
        style: const TextStyle(
          color: AppColors.grisOscuro,
          fontWeight: FontWeight.w600,
        ),
       ),
       subtitle: Text(
        "Prof. ${profesor.nombre} ${profesor.apellido} · "
        "${clase.tarifa.toStringAsFixed(2)} €",
        style: const TextStyle(color: AppColors.grisMedio),
       ),
       trailing: IconButton(
        tooltip: "Ver profesor",
        icon: const Icon(Icons.person_outline),
        color: AppColors.grisMedio,
        onPressed: onProfesorTap,
       ),
      ),
    );
  }
}