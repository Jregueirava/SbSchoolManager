package com.sbschoolmanager.sbschoolmanager_api.controller;

import com.sbschoolmanager.sbschoolmanager_api.model.Alquilar;
import com.sbschoolmanager.sbschoolmanager_api.service.AlquilarService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/alquileres")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class AlquilarController {

    private final AlquilarService alquilarService;

    @GetMapping
    public List<Alquilar> obtenerTodos() {
        return alquilarService.obtenerTodos();
    }

    //GET /api/alquileres/alumno/1
    @GetMapping("/alumno/{codAlumno}")
    public List<Alquilar> obtenerPorAlumno(@PathVariable Integer codAlumno) {
        return alquilarService.obtenerPorAlumno(codAlumno);
    }

    @PostMapping
    public Alquilar registrar(@RequestBody Alquilar alquilar) {
        return alquilarService.guardar(alquilar);
    }

}
