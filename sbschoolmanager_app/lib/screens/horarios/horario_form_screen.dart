import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../config/dias_semana.dart";
import "../../models/clase_skate.dart";
import "../../models/horario.dart";
import "../../services/horario_service.dart";

class HorarioFormScreen  extends StatefulWidget{
  const HorarioFormScreen({super.key, required this.claseSkate});

  final ClaseSkate claseSkate;

  @override
  State<HorarioFormScreen> createState() => _HorarioFormScreenState();
}

class _HorarioFormScreenState extends State<HorarioFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _horaController = TextEditingController();
  final _horarioService = HorarioService();

  String? _dia;
  TimeOfDay? _hora;
  bool _isSaving = false;

  @override
  void dispose(){
    _horaController.dispose();
    super.dispose();
  }

  String _formatHora(TimeOfDay time){
    final hours = time.hour.toString().padLeft(2, "0");
    final minutes = time.minute.toString().padLeft(2, "0");
    return "$hours:$minutes";
  }

  Future<void> _pickHora() async{
    final picked = await showTimePicker(
      context: context,
      initialTime: _hora ?? const TimeOfDay(hour: 18, minute: 0),
    );

    if(picked == null) return;

    setState((){
      _hora = picked;
      _horaController.text = _formatHora(picked);
    });
  }

  Future<void> _submit() async {
    if(!_formKey.currentState!.validate()){
      return;
    }

    setState(() => _isSaving = true);

    final horario = Horario(
      claseSkate: widget.claseSkate,
      dia: _dia!,
      hora: "${_formatHora(_hora!)}:00",
    );

    try {
      await _horarioService.crear(horario);
      if(!mounted) return;
      Navigator.of(context).pop(true);
    } catch(_){
      if(!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo guardar el horario")),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    final clase = widget.claseSkate;

    return Scaffold(
      backgroundColor: AppColors.grisFondo,
      appBar: AppBar(
        title: AppBar(
          title: const Text("Nuevo horario"),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.blanco,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                clase.tipoClase,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grisOscuro,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _dia,
                decoration: const InputDecoration(
                  labelText: "Día",
                  border: OutlineInputBorder(),
                ),
                items: DiasSemana.todos.map(
                  (dia) => DropdownMenuItem<String>(
                    value: dia,
                    child: Text(dia),
                  ),
                ).toList(),
                onChanged: (value) => setState(() => _dia = value),
                validator: (value) => value == null ? "Selecciona un día" :  null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _horaController,
                readOnly: true,
                onTap: _pickHora,
                decoration: const InputDecoration(
                  labelText: "Hora",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.schedule),
                ),
                validator: (value) => (value == null || value.isEmpty) ? "Selecciona una hora" : null,
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
                ) : const Text("Guardar horario"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}