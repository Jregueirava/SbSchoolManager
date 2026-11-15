import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../models/alumno.dart";
import "../../services/alumno_service.dart";
import "../../core/widgets/error_handler_mixin.dart";

class AlumnoFormScreen extends StatefulWidget{
  final Alumno? alumno;
  const AlumnoFormScreen({super.key, this.alumno});

  @override
  State<AlumnoFormScreen> createState()=> _AlumnoFormScreenState();
}

class _AlumnoFormScreenState extends State<AlumnoFormScreen> with ErrorHandlerMixin{
  final _formKey = GlobalKey<FormState>();
  final _service = AlumnoService();

  late TextEditingController _nombreCtrl;
  late TextEditingController _apellidoCtrl;
  late TextEditingController _dniCtrl;
  late TextEditingController _edadCtrl;

  bool get _esEdicion => widget.alumno != null;

  @override
  void initState(){
    super.initState();
    _nombreCtrl = TextEditingController(
    text: widget.alumno?.nombre ??"");
    _apellidoCtrl = TextEditingController(
      text: widget.alumno?.apellido ?? "");
    _dniCtrl = TextEditingController(
      text: widget.alumno?.dni ?? "" );
    _edadCtrl = TextEditingController(  
      text: widget.alumno?.edad.toString()??""  );
  }

  @override
  void dispose(){
    _nombreCtrl.dispose();
    _apellidoCtrl.dispose();
    _dniCtrl.dispose();
    _edadCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async{
    if(!_formKey.currentState!.validate()) return;

    final alumno = Alumno(
      codAlumno: widget.alumno?.codAlumno,
      nombre: _nombreCtrl.text.trim(),
      apellido: _apellidoCtrl.text.trim(),
      dni: _dniCtrl.text.trim(),
      edad: int.parse(_edadCtrl.text.trim()),
    );

   await ejecutarConManejo(()async{
    if(_esEdicion){
      await _service.actualizar(alumno);
    }else{
      await _service.crear(alumno);
    }
   },
   mensajeExito: _esEdicion ?"Alumno actualizado correctamente" : "Alumno creado correctamente", 
   );
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.grisFondo,
      appBar: AppBar(
        title: Text(_esEdicion ? "Editar alumno" : "Nuevo alumno"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key:_formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              //Avatar
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "DATOS PERSONALES",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grisMedio,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nombreCtrl,
                        decoration: const InputDecoration(
                          labelText: "Apellido",
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (v) => v == null || v.isEmpty ?"Campo obligatorio" : null,

                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _dniCtrl,
                          decoration: const InputDecoration(
                            labelText: "DNI",
                            prefixIcon: Icon(Icons.badge_outlined),
                        ),
                        validator: (v) => v == null || v.isEmpty ? "Campo obligatorio" :null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _edadCtrl,
                        decoration: const InputDecoration(
                          labelText: "Edad",
                          prefixIcon: Icon(Icons.cake_outlined),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (v) => v == null || v.isEmpty ? "Campo obligatorio" :  null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: guardando ? null : _guardar,
                child: guardando
                  ?const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                  Text(
                    _esEdicion ? "Guardar cambios" : "Crear alumno"
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}