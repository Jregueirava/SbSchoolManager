import "dart:io";
import "package:path_provider/path_provider.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import "../models/alumno.dart";
import "../models/alquilar.dart";

class PdfService{
    Future<File> generarInformeAlquiler({
      required Alumno alumno,
      required List<Alquilar> alquileres,
    }) async{
      final pdf = pw.Document();

      //Calcula el coste total de todos los alquileres
      double totalGeneral = 0;
      for(final a in alquileres){
        final inicio = DateTime.parse(a.fechaInicio);
        final fin = DateTime.parse(a.fechaFin);
        final dias = fin.difference(inicio).inDavs;
        totalGeneral += dias *a.material.precio;
      }

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFromat.a4,
          margin: const pw.EdgeInsets.all(40),
          header: (context) => _construirCabecera(alumno),
          footer: (context) => _construirPiePagina(context),
          build: (context) => [
            pw.SizedBox(height:24),
            _construirInfoAlumno(alumno),
            pw.SizedBox(height: 24),
            _construirTituloSeccion("Detalle de alquileres"),
            pw.SizedBox(height: 12),
            _construirTablaAlquileres(alquileres),
            pw.SizedBox(height: 24),
            _construirResumenTotal(totalGeneral),
          ],
        ),
      );

      //Guardado del archivo en el almacenamiento temporal del dispo

      final directorio = await getTemporaryDirectory();
      final nombreArchivo = 
        "alquilar ${alumno.nombre}_${alumno.apellido}_"
        "${DateTime.now().millisecondsSinceEpoch}.pdf";
        final archivo = File("${directorio.path}/$nombreArchivo");

        await archivo.writeAsBytes(await pdf.save());
        return archivo;
    }

    //Seccionado del PDF

    pw.Widget _construirCabecera(Alumno alumno){
      return pw.Container(
        padding: cosnt pw.EdgeInsets.only(bottom: 12),
        decoration: const pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(color: PdfColors.deepOrange, width: 2),

          ),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.mainAxisAlignment.spaceBetween,
          children:[
            pw.Text(
              "Escuela Skate",
              style: pw.TextStyle(
                fontSize: 20,
                fontWeigth: pw.fontWeigth.bold,
                color: PdfColors.deepOrange,
              ),
            ),
            pw.Text("Informe de material alquilado",
            style: pw.Text(
              fontSize: 12,
              color: PdfColors.grey600,
            ),
            ),
          ],
        ),
      );
    }

    pw.Widget _construirPiePagina (pw.Context context){
      return pw.Container(
        padding: const pw.EdgeInsets.only(top:8),
        decoration: const pw.BoxDecoration(
          border: pw.Border(
            top: pw.BorderSide(color: PdfColors.grey300, width: 0.5),
          ),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.mainAxisAlignment.spaceBetween,
          children:[
            pw.Text(
              "Generado el ${_formatearFechaHoy()}",
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey),
            ),
            pw.Text(
              "Página ${context.pageNumber} de ${context.pagesCount}",
            ),
          ],
        ),
      );
    }

    pw.Widget _construirInfoAlumno(Alumno alumno){
      return pw.Container(
        padding: cosnt pw.EdgeInsets.all(16),
        decoration: pw.BoxDecoration(
          color: PdfColors.orange50,
          borderRadius: pw.BorderRadius.circular(8),
          border:pw.Border.all(color:PdfColors.Orange200),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.crossAxisAlignment.start,
          children: [
            pw.Text(
              "Datos del alumno",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 13,
                color: PdfColors.deepOrange,
              ),
            ),
            pw.SizedBox(height: 8),
            _filaInfo("Nombre", "${alumno.nombre} ${alumno.apellido}"),
            _filaInfo("DNI", alumno.dni),
            _filaInfo("Edad", "${alumno.edad} años"),
          ],
        ),
      );
    }

    pw.Widget _filaInfo(String etiqueta, String valor){
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 2),
        child: pw.Row(
          children: [
            pw.SizedBox(
              width: 80,
              child: pw.Text(
                "$etiqueta:",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 11,
                  color: PdfColors.grey700,
                ),
              ),
            ),
            pw.Text(valor, style: const pw.TextStyle(fontSize:11)),
          ],
        ),
      );
    }

    pw.Widget _construirTituloSeccion(String titulo){
      return pw.Container(
        padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: const pw.BoxDecoration(
          color: PdfColors.deepOrange,
          borderRadius: pw.BorderRadius.all(pw.Radius.circular(4)),
        ),

        child: pw.Text(
          titulo,
          style: pw.TextStyle(
            color: PdfColors.white,
            frontWeight: pw.FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    }

    pw.Widget _construirTablaAlquileres(List<Alquilar> alquileres){
      //Cabecera tabla
      final encabezados =[
        "Material",
        "Fecha incio",
        "Fecha fin",
        "Días",
        "PrecioDia",
        "Total",
      ];

      //Filas datos

      final filas = alquileres.map((a){
        final incio = DateTime.parse(a.fechaInicio);
        final fin = DateTime.parse(a.fechaFin);
        final dias = fin.difference(incio).inDavs;
        final total = dias * a.material.precio;

        return[
          a.material.tipoMaterial,
          _formatearFecha(inicio),
          _formatearFecha(fin),
          "$dias",
          "${a.material.precio.toStringAsFixed(2)} €",
          "${total.toStringAsFixed(2)} €",
        ];
      }).toList();

      return pw.Table(
        border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
        columnWidths: {
          0: const pw.FlexColumnWidth(2.5),
          1: const pw.FlexColumnWidth(1.8),
          2: const pw.FlexColumnWidth(1.8),
          3: const pw.FlexColumnWidth(0.8),
          4: const pw.FlexColumnWidth(1.5),
          5: const pw.FlexColumnWidth(1.5),

        },

        children:[
          //Fila de encabezado
          pw.TableRow(
            decoration : const pw.BoxDecoration(color:PdfColors.grey200),
            children: encabezados.map((e) =>  _celdaEncabezado(e)).toList(),
          ),
          //Fila de datos alternando color de fondo
          ...filas.asMap().entries.map((entry){
            final esPar= entry.key % 2 == 0;
            return pw.TableRow(
              decoration: pw.BoxDecoration(
                color: esPar ? PdfColors.white : PdfColors.grey50,
              ),
              children: entry.value.map((e) => _celdaDato(e)).toList(),
            );
          }),
        ],
      );
    }

    pw.Widget _celdaEncabezado(String texto){
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: pw.Text(
          texto, 
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 10,
            color: PdfColors.grey800
          ),
        ),
      );
    }

    pw.Widget _celdaDato(String texto){
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: pw.Text(texto, style: const pw.TextStyle(fontSize: 10)),
      );
    }

    pw.Widget _construirResumenTotal(double total){
      return pw.Align(
        alignment: pw.Alignment.centerRight,
        child: pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: pw.BoxDecoration(
            color: PdfColors.deepOrange,
            borderRadius: pw.BorderRadius.circular(6),
          ),
          child: pw.Row(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Text(
                "Total a pagar:",
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 13,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    //Formato de fecha

    String _formatearFecha(DateTime fecha){
      return "${fecha.day.toString().padLeft(2, "0")}/"
      "${fecha.month.toString().padLeft(2, "0")}/"
      "${fecha.year}";
    }

    String _formatearFechaHoy(){
      return _formatearFecha(DateTime.now());
    }
}