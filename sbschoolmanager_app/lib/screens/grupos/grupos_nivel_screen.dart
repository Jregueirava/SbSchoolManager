import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../config/niveles_grupo.dart";
import "../../models/alumno.dart";
import "../../models/grupo.dart";
import "../../services/grupo_service.dart";
import "grupo_list_screen.dart";

class GruposNivelScreen extends StatefulWidget {
  const GruposNivelScreen({super.key, required this.alumno});

  final Alumno alumno;

  @override
  State<GruposNivelScreen> createState() => _GruposNivelScreenState();
}

class _GruposNivelScreenState extends State<GruposNivelScreen> {
  final _grupoService = GrupoService();
  late Future<List<Grupo>> _gruposFuture;

  @override
  void initState(){
    super.initState();
    _gruposFuture = _loadGrupos();
  }

  Future<List<Grupo>> _loadGrupos(){
    return _grupoService.obtenerPorAlumno(widget.alumno.codAlumno!);
  }

  void _reaload(){
    setState(() {
      _gruposFuture = _loadGrupos();
    });
  }

  Future<void> _openGrupos(String nivel) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GrupoListScreen(alumno: widget.alumno, nivel: nivel),
      ),
    );

    if(!mounted) return;
    _reaload();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.grisFondo,
      appBar: AppBar(
        title: Text("Grupos de ${widget.alumno.nombre}"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Grupo>>(
        future: _gruposFuture,
        builder: (context, snapshot) {
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

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: NivelesGrupo.todos.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index){
              final nivel = NivelesGrupo.todos[index];
              final cantidad = grupos.where((g) => g.nivel == nivel).length;

              return _NivelCard(
                nivel: nivel,
                cantidad: cantidad,
                onTap: () => _openGrupos(nivel),
              );
            },
          );
        }
      ),
    );
  }
}

class _NivelCard extends StatelessWidget {
  const _NivelCard({
    required this.nivel,
    required this.cantidad,
    required this.onTap,
  });

  final String nivel;
  final int cantidad;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context){
    final color = NivelesGrupo.colorDe(nivel);
    final colorSuave = NivelesGrupo.colorSuaveDe(nivel);

    return Card(
      color: AppColors.blanco,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: colorSuave,
          child: Icon(Icons.groups, color: color),
        ),
        title: Text(
          nivel,
          style: const TextStyle(
            color: AppColors.grisOscuro,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          cantidad == 1 ? "1 grupo" : "$cantidad grupos",
          style: const TextStyle(color: AppColors.grisMedio),
        ),
        trailing: Icon(Icons.chevron_right, color: color),
      ),
    );
  }
}