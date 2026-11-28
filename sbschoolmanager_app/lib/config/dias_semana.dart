class DiasSemana {
  const DiasSemana._();

  static const List<String> todos = [
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo",
  ];

  //Posición del día de la semana 0 -> lunes
  static indiceDe(String dia) => todos.indexOf(dia);
}