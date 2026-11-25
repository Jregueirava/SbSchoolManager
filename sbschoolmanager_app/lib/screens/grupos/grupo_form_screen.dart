import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../config/niveles_grupo.dart";
import "../../models/alumno.dart";
import "../../models/grupo.dart";
import "../../services/grupo_service.dart";

class GrupoFormScreen extends StatefulWidget {
  const GrupoFormScreen({super.key, required this.alumno, this.nivelInicial});

  final Alumno alumno;

  // Nivel que aparece preseleccionado al abrir el formulario.
  final String? nivelInicial;

  @override
  State<GrupoFormScreen> createState() => _GrupoFormScreenState();
}

class _GrupoFormScreenState extends State<GrupoFormScreen>{
  final _formKey = GlobalKey<FormState>();
  final _grupoService = GrupoService();

  late String? _nivel = widget.nivelInicial;
  bool _isSaving = false;

  Future<void> _submit() async{
    if(!_formKey.currentState!.validate()){
      return;
    }

    setState(() => _isSaving = true);

    final grupo = Grupo(alumno: widget.alumno, nivel: _nivel!);

    try{
      await _grupoService.crear(grupo);
      if(!mounted) return;
      Navigator.of(context).pop(true);
    } catch(_){
      if(!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo guardar el grupo")),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.grisFondo,
      appBar: AppBar(
        title: const Text("Nuevo grupo"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              "${widget.alumno.nombre} ${widget.alumno.apellido}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.grisOscuro,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _nivel,
              decoration: const InputDecoration(
                labelText: "Nivel",
                border: OutlineInputBorder(),
              ),
              items: NivelesGrupo.todos.map(
                (nivel) => DropdownMenuItem<String>(
                  value: nivel,
                  child: Text(nivel),
                ),
            )
            .toList(),
            onChanged: (value) => setState(() => _nivel = value),
            validator: (value) => value == null ? "Selecciona un nivel" : null,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isSaving ? null : _submit,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isSaving ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
              : const Text("Guardar grupo"),
            ),
          ],
        ),
      ),
    );
  }
}