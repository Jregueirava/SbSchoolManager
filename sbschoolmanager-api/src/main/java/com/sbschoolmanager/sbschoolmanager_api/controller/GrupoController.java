package com.sbschoolmanager.sbschoolmanager_api.controller;

import com.sbschoolmanager.sbschoolmanager_api.model.Grupo;
import com.sbschoolmanager.sbschoolmanager_api.service.GrupoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/api/grupos")
@CrossOrigin(origins= "*")
@RequiredArgsConstructor
public class GrupoController {

    private final GrupoService grupoService;

    @GetMapping
    public List<Grupo> obtenerTodos() {
        return grupoService.obtenerTodos();
    }

    //GET /api/grupos/alumno/3
    @GetMapping("/alumno/{codAlumno}")
    public List<Grupo> obtenerPorAlumno(@PathVariable Integer codAlumno) {
        return grupoService.obtenerPorAlumno(codAlumno);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Grupo> obtenerPorId(@PathVariable Integer id) {
        return grupoService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Grupo crear(@RequestBody Grupo grupo) {
        return grupoService.guardar(grupo);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Grupo> actualizar(@PathVariable Integer id,
                                            @RequestBody Grupo datos) {
        return grupoService.obtenerPorId(id)
                .map(existente -> {
                    existente.setNivel(datos.getNivel());
                    existente.setAlumno(datos.getAlumno());
                    return ResponseEntity.ok(grupoService.guardar(existente));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        grupoService.eliminar(id);
        return ResponseEntity.noContent().build();
    }

}
