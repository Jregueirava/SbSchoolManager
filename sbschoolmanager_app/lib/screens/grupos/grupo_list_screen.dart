import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../config/niveles_grupo.dart";
import "../../models/alumno.dart";
import "../../models/grupo.dart";
import "../../services/grupo_service.dart";
import "grupo_form_screen.dart";

class GrupoListScreen extends StatefulWidget {
  const GrupoListScreen({super.key, required this.alumno, this.nivel});

  final Alumno alumno;

  // Si es null se muestran los grupos de todos los niveles
  final String? nivel;

  @override
  State<GrupoListScreen> createState() => _GrupoListScreenState();
}

class _GrupoListScreenState extends State<GrupoListScreen> {
  final _grupoService = GrupoService();
  late Future<List<Grupo>> _gruposFuture;

  @override
  void initState(){
    _gruposFuture = _loadGrupos();
  }

  Future<List<Grupo>> _loadGrupos() async{
    final grupos = await _grupoService.obtenerPorAlumno(widget.alumno.codAlumno!,);

    final nivel = widget.nivel;
    if(nivel == null){
      return grupos;
    }
    return grupos.where((grupo) => grupo.nivel == nivel).toList();
  }

  void _reload(){
    setState(() {
      _gruposFuture = _loadGrupos();
    });
  }

  Future<void> _openForm() async {
    final created =  await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => GrupoFormScreen(
          alumno: widget.alumno,
          nivelInicial: widget.nivel,
        ),
      ),
    );

    if(created == true){
      _reload();
    }
  }

  Future<void> _confirmAndDelete(Grupo grupo) async {
    final confirmed =  await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("¿Seguro que quieres eliminar el grupo ${grupo.nivel}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );

    if(confirmed != true) return;

    try{
      await _grupoService.eliminar(grupo.codGrupo!);
      if(!mounted) return;
      _reload();
    } catch(_){
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo eliminar el grupo")),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.grisFondo,
      appBar: AppBar(
        title: Text(widget.nivel ?? "Todos los grupos"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openForm,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Grupo>>(
        future: _gruposFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }

          if(snapshot.hasError){
            return const Center(
              child: Text(
                "Error al cargar los grupos",
                style: TextStyle(color: AppColors.grisMedio),
              ),
            );
          }

          final grupos = snapshot.data ?? [];

          if(grupos.isEmpty){
            return const Center(
              child: Text(
                "No hay grupos todavía",
                style: TextStyle(color: AppColors.grisMedio),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: grupos.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index){
              final grupo = grupos[index];
              return _GrupoCard(
                grupo: grupo,
                onDelete: () => _confirmAndDelete(grupo),
              );
            },
          );
        },
      ),
    );
  }
}

class _GrupoCard extends StatelessWidget{
  const _GrupoCard({required this.grupo, required this.onDelete});

  final Grupo grupo;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context){
    return Card(
      color: AppColors.blanco,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: NivelesGrupo.colorSuaveDe(grupo.nivel),
          child: Icon(
            Icons.groups,
            color: NivelesGrupo.colorDe(grupo.nivel),
          ),
        ),
        title: Text(
          grupo.nivel,
          style: const TextStyle(
            color: AppColors.grisOscuro,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "${grupo.alumno.nombre} ${grupo.alumno.apellido}",
          style: const TextStyle(color: AppColors.grisMedio),
        ),
        trailing: IconButton(
          tooltip: "Eliminar grupo",
          icon: const Icon(Icons.delete_outline),
          color: AppColors.grisMedio,
          onPressed: onDelete,
        ),
      ),
    );
  }
}