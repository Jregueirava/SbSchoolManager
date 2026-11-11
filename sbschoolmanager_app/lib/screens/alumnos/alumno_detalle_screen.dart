import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../models/alumno.dart";
import "../../models/grupo.dart";
import "../../models/contratar.dart";
import "../../models/alquilar.dart";
import "../../services/grupo_service.dart";
import "../../services/contratar_service.dart";
import "../../services/alquilar_service.dart";
import "../../shared/widgets/seccion_titulo.dart";
import "../../shared/widgets/info_row.dart";
import "../materiales/informe_alquiler_screen.dart";
import "alumno_form_screen.dart";

class AlumnoDetalleScreen extends StatefulWidget {
    final Alumno alumno;
    const AlumnoDetalleScreen({super.key, required this.alumno});

    @override
    State<AlumnoDetalleScreen> createState() => _AlumnoDetalleScreenState(); 
}

class _AlumnoDetalleScreenState extends State<AlumnoDetalleScreen>{
    final _grupoService = GrupoService();
    final _contratarService = ContratarService();
    final _alquilarService = AlquilarService();

    List<Grupo> _grupos = [];
    List<Contratar> _contratos = [];
    List<Alquilar> _alquileres = [];
    bool _cargando = true;

    String _iniciales(){
        final n = widget.alumno.nombre.isNotEmpty ? widget.alumno.nombre[0] : "";
        final p = widget.alumno.apellido.isNotEmpty ? widget.alumno.apellido[0] : "";
        return "$n$p".toUpperCase();
    }

    @override
    void initState(){
        super.initState();
        _cargarDatos();
    }

    Future<void> _cargarDatos()async{
        final id = widget.alumno.codAlumno!;
        final resultados = await Future.wait([
            _grupoService.obtenerPorAlumno(id),
            _contratarService.obtenerPorAlumno(id),
            _alquilarService.obtenerPorAlumno(id),
        ]);
        setState((){
            _grupos = resultados[0] as List<Grupo>;
            _contratos = resultados[1] as List<Contratar>;
            _alquileres = resultados[2] as List<Alquilar>;
            _cargando = false;

        });
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            backgroundColor: AppColors.grisFondo,
            body: _cargando 
                ? const Center(child: CircularProgressIndicator())
                : CustomScrollView(
                    slivers:[
                        _buildHeader(),
                        SliverToBoxAdapter(child:_buildInfoBasica()),
                        SliverToBoxAdapter(child:_buildClases()),
                        SliverToBoxAdapter(child:_buildMaterial()),

                    ],
                ),

        );
    }

    Widget _buildHeader() {
    final nivel = _grupos.isNotEmpty ? _grupos.first.nivel : "Sin grupo";
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end:   Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryLight],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              CircleAvatar(
                radius: 38,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Text(
                  _iniciales(),
                  style: const TextStyle(
                    fontSize:   26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${widget.alumno.nombre} ${widget.alumno.apellido}",
                style: const TextStyle(
                  color:Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "DNI: ${widget.alumno.dni}",
                style: const TextStyle(
                  color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white38),
                ),
                child: Text(
                  nivel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize:   12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.picture_as_pdf),
          tooltip: "Informe PDF",
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  InformeAlquilerScreen(alumno: widget.alumno),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    AlumnoFormScreen(alumno: widget.alumno),
              ),
            );
            _cargarDatos();
          },
        ),
      ],
    );
  }

  Widget _buildInfoBasica() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SeccionTitulo(texto: "Información personal"),
          Card(
            child: Column(
              children: [
                InfoRow(
                  icono: Icons.cake_outlined,
                  label: "Edad",
                  valor: "${widget.alumno.edad} años",
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                InfoRow(
                  icono: Icons.family_restroom,
                  label: "Datos de padres",
                  valor: widget.alumno.datosPadres ??
                     "No registrados (mayor de edad)",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClases() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeccionTitulo(
            texto: "Clases contratadas (${_contratos.length})",
          ),
          if (_contratos.isEmpty)
            _emptyCard("Sin clases contratadas")
          else
            ..._contratos.map((c) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.skateboarding,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      c.claseSkate.tipoClase,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color:      AppColors.grisOscuro,
                      ),
                    ),
                    subtitle: Text(
                      "Prof. ${c.claseSkate.profesor.nombre} · "
                      "${c.fechaInicio} -> ${c.fechaFin}",
                      style: const TextStyle(
                        fontSize: 11,
                        color:    AppColors.grisMedio,
                      ),
                    ),
                    trailing: Text(
                      "${c.claseSkate.tarifa.toStringAsFixed(2)}€",
                      style: const TextStyle(
                        color:      AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
        ],
      ),
    );
  }

  Widget _buildMaterial() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeccionTitulo(
            texto: "Material alquilado (${_alquileres.length})",
          ),
          if (_alquileres.isEmpty)
            _emptyCard("Sin alquileres registrados")
          else
            ..._alquileres.map((a) {
              final inicio = DateTime.parse(a.fechaInicio);
              final fin    = DateTime.parse(a.fechaFin);
              final dias   = fin.difference(inicio).inDays;
              final total  = dias * a.material.precio;
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.grisSuave,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      color: AppColors.grisMedio,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    a.material.tipoMaterial,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color:      AppColors.grisOscuro,
                    ),
                  ),
                  subtitle: Text(
                    "${a.fechaInicio} -> ${a.fechaFin} · $dias días",
                    style: const TextStyle(
                      fontSize: 11,
                      color:    AppColors.grisMedio,
                    ),
                  ),
                  trailing: Text(
                    "${total.toStringAsFixed(2)}€",
                    style: const TextStyle(
                      color:      AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _emptyCard(String mensaje) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            mensaje,
            style: const TextStyle(color: AppColors.grisMedio),
          ),
        ),
      ),
    );
  }

}