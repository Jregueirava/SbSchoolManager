package com.sbschoolmanager.sbschoolmanager_api.controller;

import com.sbschoolmanager.sbschoolmanager_api.model.Contratar;
import com.sbschoolmanager.sbschoolmanager_api.service.ContratarService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/contrataciones")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class ContratarController {

    private final ContratarService contratarService;

    @GetMapping
    public List<Contratar> obtenerTodos() {
        return contratarService.obtenerTodos();
    }

    //GET /api/contrataciones/alumno/1
    @GetMapping("/alumno/{codAlumno}")
    public List<Contratar> obtenerPorAlumno(@PathVariable Integer codAlumno) {
        return contratarService.obtenerPorAlumno(codAlumno);
    }

    @PostMapping
    public Contratar registrar(@RequestBody Contratar contratar) {
        return contratarService.guardar(contratar);
    }

}
