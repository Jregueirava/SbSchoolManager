import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../models/profesor.dart";
import "../../services/profesor_service.dart";
import "profesor_form_screen.dart";
import "profesor_detalle_screen.dart";

class ProfesorListScreen extends StatefulWidget{
    const ProfesorListScreen({super.key});

    @override
    State<ProfesorListScreen>createState() => _ProfesorListScreenState();
}

class _ProfesorListScreenState extends State<ProfesorListScreen>{
    final _service = ProfesorService();
    late Future<List<Profesor>> _profesoresFuture;

    @override
    void initState(){
        super.initState();
        _cargarProfesores();
    }

    void _cargarProfesores(){
        setState(() => _profesoresFuture = _service.obtenerTodos());
    }

    Future<void> _eliminar(int id) async{
        await _service.eliminar(id);
        _cargarProfesores();
    }

    String _iniciales(Profesor p){
        final n = p.nombre.isNotEmpty ? p.nombre[0] : "";
        final a = p.apellido.isNotEmpty ? p.apellido : "";
        return "$n$a".toUpperCase();
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            backgroundColor: AppColors.grisFondo,
            appBar: AppBar(
                title: const Text("Profesores"),
                actions:[
                    IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: _cargarProfesores,
                    ),
                ],
            ),
            body: FutureBuilder<List<Profesor>>(
                future: _profesoresFuture,
                builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.hasError){
                        return Center(child: Text("Error: ${snapshot.error}"));
                    }
                    final profesores = snapshot.data!;
                    if(profesores.isEmpty){
                        return const Center(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    Icon(Icons.person_off,
                                    size: 48, color: AppColors.grisClaro),
                                    SizedBox(height: 12),
                                    Text(
                                        "No hay profesores registarados",
                                        style: TextStyle(color: AppColors.grisMedio),
                                    ),
                                ],
                            ),
                        );
                    }
                    return ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: profesores.length,
                        itemBuilder: (_, i){
                            final p = profesores[i];
                            return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor: AppColors.grisSuave,
                                        child: Text(
                                            _iniciales(p),
                                            style: const TextStyle(
                                                color: AppColors.grisOscuro,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                            ),
                                        ),
                                    ),
                                    title: Text(
                                        "${p.nombre} ${p.apellido}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.grisOscuro,
                                        ),
                                    ),
                                    subtitle: Text(
                                        "DNI: ${p.dni} ${p.anosExperiencia} años exp.",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.grisMedio,
                                        ),
                                    ),
                                    trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children:[
                                            Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 3
                                                ),
                                                decoration: BoxDecoration(
                                                    color: AppColors.primarySoft,
                                                    borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                    "${p.anosExperiencia} años",
                                                    style: const TextStyle(
                                                        color: AppColors.primary,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w600,
                                                    ),
                                                ),
                                            ),
                                            IconButton(
                                                icon: const Icon(
                                                    Icons.delete_outline,
                                                    color: AppColors.error,
                                                    size: 20,
                                                ),
                                                onPressed: () => _eliminar(p.codProfesor!),
                                            ),
                                        ],

                                    ),
                                    onTap: ()async{
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ProfesorDetalleScreen(profesor : p),
                                            ),
                                        );
                                        _cargarProfesores();
                                    },
                                ),
                            );
                        },
                    );
                },
            ),
           floatingActionButton: FloatingActionButton(
            onPressed: ()async{
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ProfesorFormScreen()),
                    );
                    _cargarProfesores();
                },
                child: const Icon(Icons.add),
            ), 
         );
    }
}