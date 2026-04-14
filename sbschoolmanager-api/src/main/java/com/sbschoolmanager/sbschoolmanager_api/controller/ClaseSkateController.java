package com.sbschoolmanager.sbschoolmanager_api.controller;

import com.sbschoolmanager.sbschoolmanager_api.model.ClaseSkate;
import com.sbschoolmanager.sbschoolmanager_api.service.ClaseSkateService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/clases")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class ClaseSkateController {

    private final ClaseSkateService claseSkateService;

    @GetMapping
    public List<ClaseSkate> obtenerTodas() {
        return claseSkateService.obtenerTodas();
    }

    //GET /api/clases/profesor/1
    @GetMapping("/profesor/{codProfesor}")
    public List<ClaseSkate> obtenerPorProfesor(@PathVariable Integer codProfesor) {
        return claseSkateService.obtenerPorProfesor(codProfesor);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ClaseSkate> obtenerPorId(@PathVariable Integer id) {
        return claseSkateService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ClaseSkate crear(@RequestBody ClaseSkate claseSkate) {
        return claseSkateService.guardar(claseSkate);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ClaseSkate> actualizar(@PathVariable Integer id,
                                                 @RequestBody ClaseSkate datos) {
        return claseSkateService.obtenerPorId(id)
                .map(existente -> {
                    existente.setTipoClase(datos.getTipoClase());
                    existente.setTarifa(datos.getTarifa());
                    existente.setProfesor(datos.getProfesor());
                    return ResponseEntity.ok(claseSkateService.guardar(existente));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        claseSkateService.eliminar(id);
        return ResponseEntity.noContent().build();
    }

}
