package com.sbschoolmanager.sbschoolmanager_api;

import com.sbschoolmanager.sbschoolmanager_api.model.Alumno;
import com.sbschoolmanager.sbschoolmanager_api.model.Profesor;
import com.sbschoolmanager.sbschoolmanager_api.model.ClaseSkate;
import com.sbschoolmanager.sbschoolmanager_api.model.Horario;
import com.sbschoolmanager.sbschoolmanager_api.service.AlumnoService;
import com.sbschoolmanager.sbschoolmanager_api.service.ProfesorService;
import com.sbschoolmanager.sbschoolmanager_api.service.ClaseSkateService;
import com.sbschoolmanager.sbschoolmanager_api.service.HorarioService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.math.BigDecimal;
import java.time.LocalTime;
import java.util.List;

@SpringBootApplication
public class SbschoolmanagerApiApplication implements CommandLineRunner {
    private static final Logger LOG = LoggerFactory.getLogger(SbschoolmanagerApiApplication.class);

    @Autowired
    private AlumnoService alumnoService;

    @Autowired
    private ProfesorService profesorService;

    @Autowired
    private ClaseSkateService claseSkateService;

    @Autowired
    private HorarioService horarioService;
	public static void main(String[] args) {
		SpringApplication.run(SbschoolmanagerApiApplication.class, args);
	}

    @Override
    public void run(String... args) throws Exception {


        //1. ALUMNOS
        LOG.info("......TEST ALUMNOS...... ");

        //Listar alumnos existentes
        List<Alumno> alumnos = alumnoService.obtenerTodos();
        LOG.info("Alumnos en BD: {}", alumnos.size());
        alumnos.forEach(a -> LOG.info("  → {}", a));

        //Crear un alumno nuevo
        Alumno nuevoAlumno = new Alumno();
        nuevoAlumno.setNombre("María");
        nuevoAlumno.setApellido("García");
        nuevoAlumno.setDni("12345678A");
        nuevoAlumno.setEdad(14);
        nuevoAlumno.setDatosPadres("Padre: 600 000 001");

        Alumno alumnoGuardado = alumnoService.guardar(nuevoAlumno);
        LOG.info("Alumno creado con ID: {}", alumnoGuardado.getCodAlumno());

        //Buscar por ID
        alumnoService.obtenerPorId(alumnoGuardado.getCodAlumno())
                .ifPresent(a -> LOG.info("Alumno encontrado por ID: {} {}", a.getNombre(), a.getApellido()));

        //Listar de nuevo para confirmar inserción
        LOG.info("Total alumnos tras inserción: {}", alumnoService.obtenerTodos().size());


        //2. PROFESORES
        LOG.info(".........TEST PROFESORES.........");

        List<Profesor> profesores = profesorService.obtenerTodos();
        LOG.info("Profesores en BD: {}", profesores.size());
        profesores.forEach(p -> LOG.info("  → {}", p));

        //Crear un profesor nuevo
        Profesor nuevoProfesor = new Profesor();
        nuevoProfesor.setNombre("Carlos");
        nuevoProfesor.setApellido("López");
        nuevoProfesor.setDni("87654321B");
        nuevoProfesor.setAnosExperiencia(5);

        Profesor profesorGuardado = profesorService.guardar(nuevoProfesor);
        LOG.info("Profesor creado con ID: {}", profesorGuardado.getCodProfesor());


        //3. CLASES SKATE

        LOG.info("....... TEST CLASES SKATE .............");

        List<ClaseSkate> clases = claseSkateService.obtenerTodas();
        LOG.info("Clases en BD: {}", clases.size());
        clases.forEach(c -> LOG.info("  → {}", c));

        //Crear una clase vinculada al profesor recién creado
        ClaseSkate nuevaClase = new ClaseSkate();
        nuevaClase.setTipoClase("INICIACION");
        nuevaClase.setTarifa(new BigDecimal("30.00"));
        nuevaClase.setProfesor(profesorGuardado);

        ClaseSkate claseGuardada = claseSkateService.guardar(nuevaClase);
        LOG.info("Clase creada con ID: {}", claseGuardada.getCodClaseSkate());

        //Buscar clases por profesor
        List<ClaseSkate> clasesPorProfesor = claseSkateService.obtenerPorProfesor(profesorGuardado.getCodProfesor());
        LOG.info("Clases del profesor {}: {}", profesorGuardado.getNombre(), clasesPorProfesor.size());


        //4. HORARIOS

        LOG.info("........ TEST HORARIOS ................");

        List<Horario> horarios = horarioService.obtenerTodos();
        LOG.info("Horarios en BD: {}", horarios.size());

        //Crear un horario vinculado a la clase
        Horario nuevoHorario = new Horario();
        nuevoHorario.setDia("LUNES");
        nuevoHorario.setHora(LocalTime.of(10, 0));
        nuevoHorario.setClaseSkate(claseGuardada);

        Horario horarioGuardado = horarioService.guardar(nuevoHorario);
        LOG.info("Horario creado con ID: {}", horarioGuardado.getCodHorario());

        //Buscar horarios por clase
        List<Horario> horariosPorClase = horarioService.obtenerPorClase(claseGuardada.getCodClaseSkate());
        LOG.info("Horarios de la clase ID {}: {}", claseGuardada.getCodClaseSkate(), horariosPorClase.size());


        //5. ELIMINAR (limpieza de datos de prueba)

        LOG.info("...... LIMPIEZA DE DATOS DE PRUEBA ........");

        horarioService.eliminar(horarioGuardado.getCodHorario());
        LOG.info("Horario eliminado: {}", horarioGuardado.getCodHorario());

        claseSkateService.eliminar(claseGuardada.getCodClaseSkate());
        LOG.info("Clase eliminada: {}", claseGuardada.getCodClaseSkate());

        profesorService.eliminar(profesorGuardado.getCodProfesor());
        LOG.info("Profesor eliminado: {}", profesorGuardado.getCodProfesor());

        alumnoService.eliminar(alumnoGuardado.getCodAlumno());
        LOG.info("Alumno eliminado: {}", alumnoGuardado.getCodAlumno());

        LOG.info("...... TEST COMPLETADO CON ÉXITO .......");
    }
}
