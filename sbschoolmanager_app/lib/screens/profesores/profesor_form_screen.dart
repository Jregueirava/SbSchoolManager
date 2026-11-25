import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "../../config/app_colors.dart";
import "../../services/profesor_service.dart";

class ProfesorFormScreen extends StatefulWidget{
  const ProfesorFormScreen({super.key});

  @override
  State<ProfesorFormScreen> createState() => _ProfesorFormScreenState();

}

class _ProfesorFormScreenState extends State<ProfesorFormScreen>{
  static final _dniPattern = RegExp(r'^[0-9XYZxyz] [0-9] {7} [A-Za-z]$');

  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  final  _experienciaController = TextEditingController();

  final _profesorService = ProfesorService();
  bool _isSaving = false;

  @override
  void dispose(){
    _nombreController.dispose();
    _apellidoController.dispose();
    _dniController.dispose();
    _experienciaController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if(!_formKey.currentState!.validate()){
      return;
    }

    setState(() => _isSaving =  true);

    try{
      final profesor = Profesor(
        nombre: _nombreController.text.trim(),
        apellido: _apellidoController.text.trim();
        dni: _dniController.text.trim().toUpperCase(),
        anosExperiencia: int.parse(_experienciaController.text),
      );
      if(!mounted) return;
      Navigator.of(context).pop(true);
    } catch(_){
      if(!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo guardar el profesor")),
        );
    }
  }

  String? _validateRequired(String? value){
    if(value == null || value.trim().isEmpty){
      return "Campo obligatorio";
    }
    return null;
  }
  
  String? _validateDni(String? value){
    final requiredError = _validateRequired(value);
    if(requiredError != null) return requiredError;

    if(!_dniPattern.hasMatch(value!.trim())){
      return "Formato no válido (Ej. 12345678A)";
    }
    return null;
  }

  String? _validateExperiencia(String? value){
    final requiredError = _validateRequired(value);
    if(requiredError != null) return requiredError;

    final anios = int.tryParse(value!);
    if(anios == null || anios < 0 || anios > 60){
      return "Introduce un número entre 0 y 60";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grisFondo,
      appBar: AppBar(
        title: const Text("Nuevo profesor"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nombreController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
              ),
              validator: _validateRequired,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _apellidoController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: "Apellido",
                border: OutlineInputBorder(),
              ) ,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dniController,
              textCapitalization: TextCapitalization.characters,
              maxLength: 9,
              decoration: const InputDecoration(
                labelText: "DNI",
                border: OutlineInputBorder(),
              ),
              validator: _validateDni,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _experienciaController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: "Años de experiencia",
                border: OutlineInputBorder(),
              ),
              validator: _validateExperiencia,
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
              : const Text("Guardar profesor"),
            ),
          ],
        ),
      ),
    );
  }

}
