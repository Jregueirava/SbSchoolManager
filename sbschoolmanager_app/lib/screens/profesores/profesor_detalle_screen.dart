import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../models/clase_skate.dart";
import "../../models/profesor.dart";
import "../../services/clase_skate_service.dart";
import "../../services/profesor_service.dart";

class ProfsorDetalleScreen extends StatefulWidget{
  const ProfesorDetalleScreen({super.key, required this.profesorId});

  final int profesorId;

  @override
  State<ProfesorDetalleScreen> createState() => _ProfesorDetalleScreenState();
}

class _ProfesorDetalleScreenState extends State<ProfesorDetalleScreen> {
  final _profesorService = ProfesorService();
  final _claseService = ClaseService();
  late Future<(Profesor, List<ClaseSkate>)> _dataFuture;

  @override
  void initState(){
    super.initState();
    _dataFuture = _loadData();
  }

  Future<(Profesor, List<ClaseSkate>)> _loadData() async{
    final profesor = await _profesorService.obtenerPorId(widget.codProfesor);
    final todasLasClases = await _claseService.obtenerTodos();
    final susClases =  todasLasClases .where((clase) => clase.codProfesor == widget.codProfesor). toList();

    return (profesor, susClases);
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.background,
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
              style: TextStyle(color: AppColors.textSecondary),
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
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if(clases.isEmpty)
              const Text(
                "Este profesor no tiene clases asignadas",
                style: TextStyle(color: AppColors.textSecondary),
              ) 
            else 
              ...clases.map(
                (clases) => Card(
                  color: AppColors.surface,
                  child: Text(clase.tipo),
                  subtitle: Text(
                    "${clase.duracion} h · ${clase.tarifa.toStringAsFixed(2)} €"
                  ),
                ),
              ),

            ]
          );
        }
      )
    );
  }
}

class _ProfesorHeader extends StatelessWidget {
  
}