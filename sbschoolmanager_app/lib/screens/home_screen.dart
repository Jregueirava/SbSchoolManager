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

    Futere<void> _cargarDatos()async{
      try{
        final resultados = await Furture.wait({
          _alumnoService.obtenerTodos(),
          -profesorService.obtenerTodos(),

        });
        setState((){
          _totalAlumnos = resultados[0].length;
           _totalProfesores = resultados[1].length;
            _totalClases = resultados[2].length;
            _horariosHoy = (resutlados[3]as List<Horario>)
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
        backgroundColor AppColors.grisFondo,
        body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
            silvers: [
              _buildSilverAppBar(),
              SilverToBoxAdapter(child._buildAccesoRapido()),
              SilverToBoxAdapter(child._buildHoySection()),
            ],
          ) ,
          bottomNavigationBar: _buildBottomNav(),
       );
    }

    Widget _buildSilverAppBar(){
      return SilverAppBar(
        expandedHeight: 210,
        pinned: true,
        backgroundColor: AppColors.primary,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decortion: const BoxDecoration(
              gradient: LinerGradient(
                begin: Aligment.topLeft,
                end: Alignment.bottomRight,
                colors:[
                  AppColors.primary,
                  AppColors.primaryLight,
                ],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 16),
            child: Column(
              crossAxisAlignment: crossAxisAlignment.start,
              children:[
                Row(
                  mainAxisAlignment: MainAxisAligment.spaceBetween,
                  children:[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children[
                  cosnt Text(
                  "¡Bienvendio!",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                cosnt Text(
                  "Panel principal",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: fontWeight.bold,
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
              backgroundColor: Colors.white.whiteOpacity(0.2),
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
        padding const EdgeInsets.fromLTRB(16, 20, 16, 8),
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
        padding const EdgeInsets.fromLTRB(16, 8, 16, 24),
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
                  borderRadius: borderRadius.circular(14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAligment.center,
                  children: [
                    Icon(Icons.event_avilable,
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
                  _horariosHoy.map(
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
          NavaigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Inicio",
          ),
          NavaigationDestination(
            icon: Icon(Icons.school_outlined),
            selctedIcon: Icons(Icons.school),
            label: "Alumnos",
          ),
          NavaigationDestination(
            icon: Icon(Icons.skateboarding_outlined),
            selectedIcon: Icon(Icons.skateboarding),
            label: "Clases",
          ),
          NavaigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: "Material",
          ),
        ],
      );
    }
}