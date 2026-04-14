package com.sbschoolmanager.sbschoolmanager_api.controller;

import com.sbschoolmanager.sbschoolmanager_api.model.Material;
import com.sbschoolmanager.sbschoolmanager_api.service.MaterialService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/materiales")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class MaterialController {

    private final MaterialService materialService;

    @GetMapping
    public List<Material> obtenerTodos() {
        return materialService.obtenerTodos();
    }

    @GetMapping("/alumno/{codAlumno}")
    public List<Material> obtenerPorAlumno(@PathVariable Integer codAlumno) {
        return materialService.obtenerPorAlumno(codAlumno);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Material> obtenerPorId(@PathVariable Integer id) {
        return materialService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Material crear(@RequestBody Material material) {
        return materialService.guardar(material);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Material> actualizar(@PathVariable Integer id,
                                               @RequestBody Material datos) {
        return materialService.obtenerPorId(id)
                .map(existente -> {
                    existente.setTipoMaterial(datos.getTipoMaterial());
                    existente.setPrecio(datos.getPrecio());
                    existente.setTiempo(datos.getTiempo());
                    existente.setAlumno(datos.getAlumno());
                    return ResponseEntity.ok(materialService.guardar(existente));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        materialService.eliminar(id);
        return ResponseEntity.noContent().build();
    }

}
