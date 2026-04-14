package com.sbschoolmanager.sbschoolmanager_api.controller;

import com.sbschoolmanager.sbschoolmanager_api.model.Alumno;
import com.sbschoolmanager.sbschoolmanager_api.service.AlumnoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/alumnos")
@CrossOrigin(origins="*")//Para permitir que flutter llame a esta API(es devido a una restriccion CORS)
@RequiredArgsConstructor
public class AlumnoController {

    private final AlumnoService alumnoService;

    //GET http://localhost:8080/api/alumnos
    @GetMapping
    public List<Alumno>obtenerTodos(){
        return alumnoService.obtenerTodos();
    }

    //GET http://localhost:8080/api/alumnos/1
    @GetMapping("/{id}")
    public ResponseEntity<Alumno> obtenerPorId(@PathVariable Integer id){
        return alumnoService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    //POST http://localhost:8080/api/alumnos
    @PostMapping
    public Alumno crear(@RequestBody Alumno alumno){
        return alumnoService.guardar(alumno);
    }

    //DELETE http://localhost:8080/api/alumnos/1
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id){
        alumnoService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}
