package com.sbschoolmanager.sbschoolmanager_api.controller;

import com.sbschoolmanager.sbschoolmanager_api.model.Profesor;
import com.sbschoolmanager.sbschoolmanager_api.service.ProfesorService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/profesores")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class ProfesorController {

    private final ProfesorService profesorService;

    @GetMapping
    public List<Profesor> obtenerTodos(){
        return profesorService.obtenerTodos();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Profesor> obtenerPorId(@PathVariable Integer id){
        return profesorService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Profesor crear(@RequestBody Profesor profesor){
        return profesorService.guardar(profesor);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Profesor> actualizar(@PathVariable Integer id, @RequestBody Profesor datos){
        return profesorService.obtenerPorId(id)
                .map(existente -> {
                    existente.setNombre(datos.getNombre());
                    existente.setApellido(datos.getApellido());
                    existente.setDni(datos.getDni());
                    existente.setAnosExperiencia(datos.getAnosExperiencia());
                    return ResponseEntity.ok(profesorService.guardar(existente));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping({"/{id}"})
    public ResponseEntity<Void> eliminar(@PathVariable Integer id){
        profesorService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}
