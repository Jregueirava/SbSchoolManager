import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../models/horario.dart";
import "../../services/horario_service.dart";

class HorarioSemanalScreen extends StatefulWidget {
  const HorarioSemanalScreen({super.key});

  @override
  State<HorarioSemanalScreen> createState() =>
      _HorarioSemanalScreenState();
}

class _HorarioSemanalScreenState extends State<HorarioSemanalScreen> {
  final _service = HorarioService();
  List<Horario> _todos    = [];
  bool          _cargando = true;
  int           _diaSeleccionado = DateTime.now().weekday - 1;

  static const _dias = [
    "Lunes", "Martes", "Miércoles",
    "Jueves", "Viernes", "Sábado", "Domingo",
  ];
  static const _diasCortos = ["L", "M", "X", "J", "V", "S", "D"];

  // Colores de acento para cada clase — dentro de la paleta
  static const _coloresAcento = [
    AppColors.primary,
    AppColors.primaryLight,
    AppColors.grisOscuro,
    AppColors.grisMedio,
    Color(0xFF283593),
    Color(0xFF1A237E),
  ];

  @override
  void initState() {
    super.initState();
    _cargarHorarios();
  }

  Future<void> _cargarHorarios() async {
    final lista = await _service.obtenerTodos();
    setState(() {
      _todos    = lista;
      _cargando = false;
    });
  }

  List<Horario> get _horariosDia {
    final dia = _dias[_diaSeleccionado];
    return _todos.where((h) => h.dia == dia).toList()
      ..sort((a, b) => a.hora.compareTo(b.hora));
  }

  Color _colorParaClase(String tipo) {
    final idx = tipo.hashCode.abs() % _coloresAcento.length;
    return _coloresAcento[idx];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grisFondo,
      appBar: AppBar(title: const Text("Horario semanal")),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildTiraDias(),
                Expanded(child: _buildLista()),
              ],
            ),
    );
  }

  Widget _buildTiraDias() {
    final hoy = DateTime.now();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
      child: Row(
        children: List.generate(7, (i) {
          final sel    = i == _diaSeleccionado;
          final diaNum = hoy
              .subtract(Duration(days: hoy.weekday - 1 - i))
              .day;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _diaSeleccionado = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: sel
                      ? AppColors.blanco
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      _diasCortos[i],
                      style: TextStyle(
                        color: sel
                            ? AppColors.primary
                            : Colors.white70,
                        fontSize:   11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "$diaNum",
                      style: TextStyle(
                        color: sel
                            ? AppColors.primary
                            : Colors.white,
                        fontSize:   16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLista() {
    final horarios = _horariosDia;
    if (horarios.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.event_busy,
                size: 64, color: AppColors.grisClaro),
            const SizedBox(height: 12),
            Text(
              "No hay clases el ${_dias[_diaSeleccionado]}",
              style: const TextStyle(
                color:   AppColors.grisMedio,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: horarios.length,
      itemBuilder: (_, i) {
        final h     = horarios[i];
        final color = _colorParaClase(h.claseSkate.tipoClase);
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      topLeft:    Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.schedule,
                            color: color,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                h.claseSkate.tipoClase,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:   14,
                                  color:      AppColors.grisOscuro,
                                ),
                              ),
                              Text(
                                "Prof. ${h.claseSkate.profesor.nombre} "
                                "${h.claseSkate.profesor.apellido}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color:    AppColors.grisMedio,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            h.hora,
                            style: TextStyle(
                              color:      color,
                              fontWeight: FontWeight.bold,
                              fontSize:   13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}