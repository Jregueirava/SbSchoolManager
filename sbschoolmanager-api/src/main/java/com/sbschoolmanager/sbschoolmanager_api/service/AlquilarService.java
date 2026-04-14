package com.sbschoolmanager.sbschoolmanager_api.service;

import com.sbschoolmanager.sbschoolmanager_api.model.Alquilar;
import com.sbschoolmanager.sbschoolmanager_api.repository.AlquilarRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AlquilarService {

    private final AlquilarRepository alquilarRepository;

    public List<Alquilar> obtenerTodos() {
        return alquilarRepository.findAll();
    }

    public List<Alquilar> obtenerPorAlumno(Integer codAlumno) {
        return alquilarRepository.findByAlumnoCodAlumno(codAlumno);
    }

    public Alquilar guardar(Alquilar alquilar) {
        return alquilarRepository.save(alquilar);
    }
}
