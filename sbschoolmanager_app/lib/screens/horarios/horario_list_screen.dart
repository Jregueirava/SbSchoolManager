import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../config/dias_semana.dart";
import "../../models/clase_skate.dart";
import "../../models/horario.dart";
import "../../services/horario_service.dart";
import "horario_form_screen.dart";

class HorarioListScreen extends StatefulWidget {
  const HorarioListScreen({super.key, required this.claseSkate});

  final ClaseSkate claseSkate;

  @override
  State<HorarioListScreen> createState() => _HorarioListScreenState();
}

class _HorarioListScreenState extends State<HorarioListScreen> {
  final _horarioService = HorarioService();
  late Future<List<Horario>> _horariosFuture;

  @override
  void initState(){
    super.initState();
    _horariosFuture = _loadHorarios();
  }

  Future<List<Horario>> _loadHorarios() async{
    final horarios = await _horarioService.obtenerPorClase(
      widget.claseSkate.codClaseSkate!,
    );

    horarios.sort(_compararHorarios);
    return horarios;
  }

  int _compararHorarios(Horario a, Horario b){
    final porDia = DiasSemana.indiceDe(a.dia).compareTo(DiasSemana.indiceDe(b.dia),
    );
    return porDia != 0 ? porDia : a.hora.compareTo(b.hora);
  }

  void _reaload(){
    setState((){
      _horariosFuture = _loadHorarios();
    });
  }

  Future<void> _openForm() async {
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => HorarioFormScreen(claseSkate: widget.claseSkate),
        ),
    );

    if(created == true){
      _reaload();
    }
  }

  Future<void> _confirmAndDelete(Horario horario) async{
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Eliminar hoario"),
        content: Text("Seguro que quieres eliminar el horario del ${horario.dia}?",
        ),
        actions: [
          TextButton(
            onPressed: ()=> Navigator.of(dialogContext).pop(false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: ()=> Navigator.of(dialogContext).pop(true),
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );

    if(confirmed != true) return;

    try{
      await _horarioService.eliminar(horario.codHorario!);
      if(!mounted) return;
      _reaload();
    } catch(_){
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se puedo eliminar el horario")),
      );
    }
  }

  @override
  Widget build(BuildContext contex){
    final clase = widget.claseSkate;

    return Scaffold(
      backgroundColor: AppColors.grisFondo,
      appBar: AppBar(
        title: const Text("Horarios"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.blanco,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openForm,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.blanco,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          _ClaseHeader(clase: clase),
          Expanded(
            child: FutureBuilder<List<Horario>>(
              future: _horariosFuture,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }

                if(snapshot.hasError){
                  return const Center(
                    child: Text(
                      "Error al cargar los horarios",
                      style: TextStyle(color: AppColors.grisMedio),
                    )
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: horarios.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index){
                    final horario = horarios[index];
                    return _HorarioCard(
                      horario: horario,
                      onDelete: () => _confirmAndDelete(horario),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ClaseHeader extends StatelessWidget {
  const _ClaseHeader({required this.clase});

  final ClaseSkate clase;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            clase.tipoClase,
            style: const TextStyle(
              color: AppColors.blanco,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Prof. ${clase.profesor.nombre} ${clase.profesor.apellido}",
            style: const TextStyle(color: AppColors.primarySoft),
          ),
        ],
      ),
    );
  }
}

class _HorarioCard extends StatelessWidget {
  const _HorarioCard({required this.horario, required this.onDelete});

  final Horario horario;
  final VoidCallback onDelete;

  String get _horaCorta{
    final hora = horario.hora;
    return hora.length >= 5 ? hora.substring(0, 5) : hora;
  }

  @override
  Widget build(BuildContext context){
    return Card(
      color: AppColors.blanco,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.primarySoft,
          child: Icon(Icons.schedule, color: AppColors.primary),
        ),
        title: Text(
          horario.dia,
          style: const TextStyle(
            color: AppColors.grisOscuro,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          _horaCorta,
          style: const TextStyle(color: AppColors.grisMedio),
        ),
        trailing: IconButton(
          tooltip: "Eliminar horario",
          icon: const Icon(Icons.delete_outline),
          color: AppColors.grisMedio,
          onPressed: onDelete,
        ),
      ),
    );
  }
}
