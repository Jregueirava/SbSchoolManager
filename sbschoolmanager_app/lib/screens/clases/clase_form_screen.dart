import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../models/clase_skate.dart";
import "../../models/profesor.dart";
import "../../services/clase_skate_service.dart";
import "../../services/profesor_service.dart";

class ClaseFormScreen extends StatefulWidget{
  const ClaseFormScreen({super.key});

  @override
  State<ClaseFormScreen> createState() => _ClaseFormScreenState();
}

class _ClaseFormScreenState extends State<ClaseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tipoController = TextEditingController();
  final _tarifaController = TextEditingController();
  final _duracionController = TextEditingController();

  final _claseService = ClaseSkateService();
  final _profesorService = ProfesorService();

  late final Future<List<Profesor>> _profesoresFuture;
  Profesor? _profesor;
  bool _isSaving = false;

  @override
  void initState(){
    super.initState();
    _profesoresFuture = _profesorService.obtenerTodos();
  }

  @override
  void dispose(){
    _tipoController.dispose();
    _tarifaController.dispose();
    super.dispose();
  }

  Future<void> _submit() async{
    if(!_formKey.currentState!.validate()){
      return;
    }

    setState(() => _isSaving = true);

    final clase = ClaseSkate(
      profesor: _profesor!,
      tipoClase: _tipoController.text.trim(),
      tarifa: double.parse(_tarifaController.text.replaceAll(",", ".")),
    );

    try{
      await _claseService.crear(clase);
      if(!mounted) return;
      Navigator.of(context).pop(true);
    } catch(_){
      if(!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo guardar la clase")),
      );
    }
  }

  String? _validateRequired(String? value){
    if(value == null || value.trim().isEmpty){
      return "Campo obligatorio";
    }
    return null;
  }

  String? _validateTarifa(String? value){
    final requiredError = _validateRequired(value);
    if(requiredError != null) return requiredError;

    final tarifa = double.tryParse(value!.replaceAll(",", "."));
    if(tarifa == null || tarifa <= 0){
      return "Introduce un número mayor que 0";
    }
    return null;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.grisFondo,
      appBar: AppBar(
        title: const Text("Nueva clase"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.blanco,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _tipoController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: "Tipo de clase",
                border: OutlineInputBorder(),
              ),
              validator: _validateRequired,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tarifaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Tarifa (€) ",
                border: OutlineInputBorder(),
              ),
              validator: _validateTarifa,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _duracionController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Duración (horas)",
                border: OutlineInputBorder(),
              ),
              validator: _validateTarifa,
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<Profesor>>(
              future: _profesoresFuture,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const LinearProgressIndicator();
                }

                if(snapshot.hasError){
                  return const Text(
                    "No se pudieron cargar los profesores",
                    style: TextStyle(color: AppColors.grisMedio),
                  );
                }

                final profesores = snapshot.data ?? [];

                return DropdownButtonFormField<Profesor>(
                  initialValue: _profesor,
                  decoration: const InputDecoration(
                    labelText: "Profesor",
                    border: OutlineInputBorder(),
                  ),
                  items: profesores.map(
                    (profesor) => DropdownMenuItem<Profesor>(
                      value: profesor,
                      child: Text("${profesor.nombre} ${profesor.apellido}"),
                    ),
                  )
                  .toList(),
                  onChanged: (value) => setState(() => _profesor = value),
                  validator: (value) => value == null ? "Selecciona un profesor" : null,
                );
              },
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
                : const Text("Guardar clase"),
            ),
          ],
        ),
      ),
       
    );
  }
}