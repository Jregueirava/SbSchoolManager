package com.sbschoolmanager.sbschoolmanager_api.service;

import com.sbschoolmanager.sbschoolmanager_api.model.Contratar;
import com.sbschoolmanager.sbschoolmanager_api.repository.ContratarRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContratarService {

    private final ContratarRepository contratarRepository;

    public List<Contratar> obtenerTodos() {
        return contratarRepository.findAll();
    }

    public List<Contratar> obtenerPorAlumno(Integer codAlumno) {
        return contratarRepository.findByAlumnoCodAlumno(codAlumno);
    }

    public Contratar guardar(Contratar contratar) {
        return contratarRepository.save(contratar);
    }

}
