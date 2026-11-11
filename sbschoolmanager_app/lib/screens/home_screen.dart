import "package:flutter/material.dart";
import "../config/app_colors.dart";
import "../models/horario.dart";
import "../services/alumno_service.dart";
import "../services/profesor_service.dart";
import "../services/clase_skate_service.dart";
import "../services/horario_service.dart";
import "../shared/widgets/stat_chip.dart";
import "../shared/widgets/menu_card.dart";
import "../shared/widgets/horario_hoy_card.dart";
import "alumnos/alumno_list_screen.dart";
import "profesores/profesor_list_screen.dart";
import "clases/clase_list_screen.dart";
import "materiales/material_list_screen.dart";

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override 
  State<HomeScreen> createState() => _HomeScreenState();
}
  class _HomeScreenState extends State<HomeScreen>{
    final _alumnoService = AlumnoService();
    final _profesorService = ProfesorService();
    final _claseService = ClaseSkateService();
    final _horarioService = HorarioService();

    int _totalAlumnos = 0;
    int _totalProfesores = 0;
    int _totalClases = 0;
    List<Horario> _horariosHoy =[];
    bool _cargando = true;
    int _indexNav = 0;

    String get _diaHoy{
      const dias =[
        "Lunes", "Martes", "Miércoles",
        "Juves", "Viernes", "Sábado", "Domingo",
      ];
      return dias[DateTime.now().weekday -1];
    }

    @override
    void initState(){
      super.initState();
      _cargarDatos();
    }

    Future<void> _cargarDatos()async{
      try{
        final resultados = await Future.wait({
          _alumnoService.obtenerTodos(),
          _profesorService.obtenerTodos(),

        });
        setState((){
          _totalAlumnos = resultados[0].length;
           _totalProfesores = resultados[1].length;
            _totalClases = resultados[2].length;
            _horariosHoy = (resultados[3]as List<Horario>)
            .where((h) => h.dia == _diaHoy).toList();
            _cargando = false;
        });
      } catch(_){
        setState(()=> _cargando=false);
      }
    }
    @override
    Widget build (BuildContext context){
      return Scaffold(
        backgroundColor: AppColors.grisFondo,
        body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
            slivers: [
              _buildSilverAppBar(),
              SliverToBoxAdapter(child:_buildAccesoRapido()),
              SliverToBoxAdapter(child:_buildHoySection()),
            ],
          ) ,
          bottomNavigationBar: _buildBottomNav(),
       );
    }

    Widget _buildSilverAppBar(){
      return SliverAppBar(
        expandedHeight: 210,
        pinned: true,
        backgroundColor: AppColors.primary,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:[
                  AppColors.primary,
                  AppColors.primaryLight,
                ],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                  const Text(
                  "¡Bienvendio!",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  "Panel principal",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Hoy es $_diaHoy"
                  "${_horariosHoy.length} clases",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            StatChip(valor: _totalAlumnos, label: "Alumnos"),
            const SizedBox(width: 8),
            StatChip(valor: _totalProfesores, label: "Profesores"),
            const SizedBox(width: 8),
            StatChip(valor: _totalClases, label: "Clases"),
          ],
        ),
        ],
          ),
        ),
        ),
      );
    }

    Widget _buildAccesoRapido(){
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              const Text(
                "ACCESO RÁPIDO",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grisMedio,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),
              MenuCard(
                icono: Icons.school,
                color: AppColors.primarySoft,
                titulo: "Alumnos",
                subtitulo: "Gestión completa",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AlumnoListScreen()),
                  ),
                ),
                MenuCard(
                  icono: Icons.person,
                  color: AppColors.grisSuave,
                  titulo: "Profesores",
                  subtitulo: "Equipo docente",
                  onTap: ()=> Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_)=> const ProfesorListScreen()),

                    ),
                  ),
                MenuCard(
                  icono: Icons.skateboarding,
                  color: AppColors.primarySoft,
                  titulo: "Clases",
                  subtitulo: "Street Ramp Freestyle",
                  onTap: ()=> Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_)=> const ClaseListScreen()),
                    ),
                  ),
                  MenuCard(
                    icono: Icons.inventory_2,
                    color: AppColors.grisSuave,
                    titulo: "Material",
                    subtitulo: "Gestion de alquileres",
                    onTap: ()=> Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_)=> const MaterialListScreen()),
            ),
           ),
         ],
        ),
      );
    }
    Widget _buildHoySection(){
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CLASES DE HOY $_diaHoy".toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.grisMedio,
                letterSpacing: 1,
              ),
            ),
            const SizedBox (height: 10),
            if(_horariosHoy.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.blanco,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_available,
                      color: AppColors.grisClaro),
                    SizedBox(width: 8),
                    Text(
                      "No hay clases programadas hoy",
                      style: TextStyle(color: AppColors.grisMedio),
                    ),
                  ],
                ),
              ) 
              else
                 ... _horariosHoy.map(
                    (h) => HorarioHoyCard(horario: h),
                  ),
          ],
        ),
      );
    }

    Widget _buildBottomNav(){
      return NavigationBar(
        selectedIndex: _indexNav,
        onDestinationSelected: (i)=> setState(()=> _indexNav=i),
        destinations: const[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Inicio",
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: "Alumnos",
          ),
          NavigationDestination(
            icon: Icon(Icons.skateboarding_outlined),
            selectedIcon: Icon(Icons.skateboarding),
            label: "Clases",
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: "Material",
          ),
        ],
      );
    }
}