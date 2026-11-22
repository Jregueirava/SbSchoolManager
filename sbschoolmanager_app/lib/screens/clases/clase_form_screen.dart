import "package:flutter/material.dart";
import "../../config/app_colors.dart";
import "../../models/clase_skate.dart";
import "../../models/profesor.dart";
import "../../services/profesor_service.dart";

class CalseFormScreen extends SatefulWidget{
  const ClaseFormScreen({super.key});

  @override
  State<ClaseFormScreen> createState() => _ClaseFormScreenState();
}

class _ClaseFormScreenState extends State<ClaseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tipoController = TextEditingController();
  final _tarifaController = TextEditingController();
  final _duracionController = TextEditingController();
}