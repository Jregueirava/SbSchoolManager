import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../models/clase_skate.dart";
import "../../models/profesor.dart";
import "../../services/clase_skate_service.dart";
import "../../services/profesor_service.dart";

class ProfesorDetalleScreen extends StatefulWidget{
  const ProfesorDetalleScreen({super.key, required this.codProfesor});

  final int codProfesor;

  @override
  State<ProfesorDetalleScreen> createState() => _ProfesorDetalleScreenState();
}

class _ProfesorDetalleScreenState extends State<ProfesorDetalleScreen> {
  final _profesorService = ProfesorService();
  final _claseService = ClaseSkateService();
  late Future<(Profesor, List<ClaseSkate>)> _dataFuture;

  @override
  void initState(){
    super.initState();
    _dataFuture = _loadData();
  }

  Future<(Profesor, List<ClaseSkate>)> _loadData() async{
    final profesores = await _profesorService.obtenerTodos();
    final profesor = profesores.firstWhere((profesor) => profesor.codProfesor == widget.codProfesor);
    final todasLasClases = await _claseService.obtenerTodas();
    final susClases =  todasLasClases .where((clase) => clase.profesor.codProfesor == widget.codProfesor). toList();

    return (profesor, susClases);
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.grisFondo,
      appBar: AppBar(
        title: const Text("Profesor"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<(Profesor, List<ClaseSkate>)>(
        future: _dataFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }

          if(snapshot.hasError || !snapshot.hasData){
            return const Center(
              child: Text("Error  al cargar el profesor",
              style: TextStyle(color: AppColors.grisMedio),
              ),
            );
          }
          final (profesor, clases) = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _ProfesorHeader(profesor: profesor),
              const SizedBox(height: 24),
              Text(
                "Sus clases",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.grisOscuro,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if(clases.isEmpty)
              const Text(
                "Este profesor no tiene clases asignadas",
                style: TextStyle(color: AppColors.grisMedio),
              ) 
            else 
              ...clases.map(
                (clase) => Card(
                  color: AppColors.blanco,
                  child: ListTile(
                  title: Text(clase.tipoClase),
                  subtitle: Text(
                    "${clase.tarifa.toStringAsFixed(2)} €"
                    ),
                  ),
               ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProfesorHeader extends StatelessWidget {
  const _ProfesorHeader({required this.profesor});

  final Profesor profesor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.blanco,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, size: 32, color: Colors.white),
          ),
         const SizedBox(width: 16),
         Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${profesor.nombre} ${profesor.apellido}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grisOscuro,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${profesor.anosExperiencia} años de experiencia",
                style: const TextStyle(color: AppColors.grisMedio),
              ),
              Text(
                "DNI: ${profesor.dni}",
                style: const TextStyle(color: AppColors.grisMedio),
              ),
            ],
          ),
         ) ,
        ],
      ),
    );
  }
}