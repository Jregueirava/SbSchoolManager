import"package:flutter/material.dart";
import"../../config/app_colors.dart";
import"../../models/alumno.dart";
import"../../models/grupo.dart";
import"../../services/alumno_service.dart";
import"../../services/grupo_service.dart";
import"alumno_form_screen.dart";
import"alumno_detalle_screen.dart";

class AlumnoListScreen extends StatefulWidget{
    const AlumnoListScreen({super.key});

    @override
    State<AlumnoListScreen> createState()=> _AlumnoListScreenSate();
}

class _AlumnoListScreenSate extends State<AlumnoListScreen>{
    final _alumnoService = AlumnoService();
    final _grupoService = GrupoService();
    final _searchCtrl = TextEditingController();

    late Future<List<Alumno>> _alumnosFuture;
    List<Alumno> _todos = [];
    List<Alumno> _filtrados = [];
    String _nivelFiltro = "Todos";
    Map<int, String> _nivelPorAlumno = {};

    static const _niveles= [
        "Todos", "Principiante", "Intermedio", "Avanzado"
    ];

    static const _colorNivel ={
        "Principiante": AppColors.principiante,
        "Intermedio" : AppColors.intermedio,
        "Avanzado": AppColors.avanzado,
    };

    static const _bgNivel={
        "Principiante" : AppColors.principianteSuave,
        "Intermedio" : AppColors.intermedioSuave,
        "Avanzado" : AppColors.avanzadoSuave,
    };

    @override
    void initState(){
        super.initState();
        _cargarAlumnos();
    }

    void _cargarAlumnos(){
        setState((){
            _alumnosFuture = _alumnoService.obtenerTodos().then((lista)async {
                _todos = lista;
                for(final a in lista){
                    final grupos= await _grupoService.obtenerPorAlumno(a.codAlumno!);
                    if(grupos.isNotEmpty){
                        _nivelPorAlumno[a.codAlumno!] = grupos.first.nivel;
                    }
                }
                _aplicarFiltros();
                return lista;
            });
        });
    }

    void _aplicarFiltros(){
        final q = _searchCtrl.text.toLowerCase();
        setState((){
            _filtrados = _todos.where((a){
                final coincideBusqueda = "${a.nombre} ${a.apellido}".toLowerCase().contains(q)|| a.dni.toLowerCase().contains(q);
                final nivel = _nivelPorAlumno[a.codAlumno] ?? "";
                final coincideNivel = _nivelFiltro == "Todos" || nivel == _nivelFiltro;

                return coincideBusqueda && coincideNivel;

            }).toList();
        });
    }

    Future<void> _eliminar(int id) async{
        await _alumnoService.eliminar(id);
        _cargarAlumnos();
    }

    String _iniciales(Alumno a){
        final n = a.nombre.isNotEmpty ? a.nombre[0] : "";
        final p = a.apellido.isNotEmpty ? a.apellido[0] : "";

        return "$n$p".toUpperCase();
    }

    @override 
    void dispose(){
        _searchCtrl.dispose();
        super.dispose();
    }

    @override
    Widget build (BuildContext context){
        return Scaffold(
            backgroundColor: AppColors.grisFondo,
            appBar: AppBar(
                title: const Text("Alumnos"),
                actions: [
                    IconButton(
                        icon: const Icon (Icons.refresh),
                        onPressed: _cargarAlumnos,
                    ),
                ],
            ),
            body: Column(
                children: [
                    _buildBuscador(),
                    _buildFiltros(),
                    Expanded(child: _buildLista()),
                ],
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: ()async{
                    await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AlumnoFormScreen()),
                    );
                    _cargarAlumnos();
                },
                child: const Icon(Icons.add),
            ),
        );
    }

    Widget _buildBuscador(){
        return Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
            child: TextField(
                controller: _searchCtrl,
                onChanged: (_) => _aplicarFiltros(),
                decoration: InputDecoration(
                    hintText: "Buscador por nombre o DNI...",
                    hintStyle: const TextStyle(color: AppColors.grisClaro),
                    prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.grisMedio,
                    ),
                    suffixIcon: _searchCtrl.text.isNotEmpty ? IconButton(
                        icon: const Icon(Icons.clear,
                        color: AppColors.grisMedio),
                        onPressed: (){
                            _searchCtrl.clear();
                            _aplicarFiltros();
                        },
                    )
                    :null,
                ),
            ),
        );
    }

    Widget _buildFiltros(){
        return SizedBox(
            height: 44,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _niveles.length,
                separatorBuilder:(_, __) => const SizedBox(width: 8),
                itemBuilder:(_, i){
                    final nivel = _niveles[i];
                    final seleccionado = _nivelFiltro == nivel;
                    return FilterChip(
                        label: Text(nivel),
                        selected: seleccionado,
                        onSelected: (_){
                            setState(() => _nivelFiltro = nivel);
                            _aplicarFiltros();
                        },
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.blanco,
                        labelStyle: TextStyle(
                            color: seleccionado ? AppColors.blanco : AppColors.grisOscuro,
                            fontWeight: FontWeight.w500, fontSize: 12,

                        ),
                        checkmarkColor: AppColors.blanco,
                        side: BorderSide(
                            color: seleccionado ? AppColors.primary : AppColors.grisClaro,
                        ),
                    );
                },
            ),
        );
    }

    Widget _buildLista(){
        return FutureBuilder<List<Alumno>>(
            future: _alumnosFuture,
            builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                }

                if(snapshot.hasError){
                    return Center(
                        child: Text(
                            "Error: ${snapshot.error}",
                            style: const TextStyle(color:AppColors.error),
                        ),
                    );
                }

                if(_filtrados.isEmpty){
                    return const Center(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                Icon(Icons.search_off, size: 48, color: AppColors.grisClaro),
                                SizedBox(height: 12),
                                Text(
                                    "No se encontraron alumnos", 
                                    style: TextStyle(color: AppColors.grisMedio),
                                ),
                            ],
                        ),
                    );
                }

                return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _filtrados.length,
                    itemBuilder: (_, i){
                        final alumno = _filtrados[i];
                        final nivel = _nivelPorAlumno[alumno.codAlumno] ?? "";
                        return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                                leading: CircleAvatar(
                                    backgroundColor: AppColors.primarySoft,
                                    child: Text(
                                        _iniciales(alumno),
                                        style: const TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                        ),
                                    ),
                                ),
                                title: Text(
                                    "${alumno.nombre} ${alumno.apellido}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.grisOscuro,
                                    ),
                                ),
                                subtitle: Text(
                                    "DNI: ${alumno.dni} ${alumno.edad} años",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.grisMedio,
                                    ),
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children:[
                                        if(nivel.isNotEmpty)
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 3
                                            ),
                                            decoration: BoxDecoration(
                                                color: _bgNivel[nivel],
                                                borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                                nivel,
                                                style: TextStyle(
                                                    color: _colorNivel[nivel],
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
                                            onPressed: () => _eliminar(alumno.codAlumno!),
                                        ),
                                    ],
                                ),
                                onTap: ()async{
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AlumnoDetalleScreen(alumno: alumno),
                                        ),
                                    );
                                    _cargarAlumnos();
                                },
                            ),
                        );
                    },
                );
            },
        );
    }
}