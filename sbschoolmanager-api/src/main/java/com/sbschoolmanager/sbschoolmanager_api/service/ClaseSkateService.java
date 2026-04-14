package com.sbschoolmanager.sbschoolmanager_api.service;

import com.sbschoolmanager.sbschoolmanager_api.model.ClaseSkate;
import com.sbschoolmanager.sbschoolmanager_api.repository.ClaseSkateRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ClaseSkateService {

    private final ClaseSkateRepository claseSkateRepository;

    public List<ClaseSkate> obtenerTodas() {
        return claseSkateRepository.findAll();
    }

    public Optional<ClaseSkate> obtenerPorId(Integer id) {
        return claseSkateRepository.findById(id);
    }

    public List<ClaseSkate> obtenerPorProfesor(Integer codProfesor) {
        return claseSkateRepository.findByProfesorCodProfesor(codProfesor);
    }

    public ClaseSkate guardar(ClaseSkate claseSkate) {
        return claseSkateRepository.save(claseSkate);
    }

    public void eliminar(Integer id) {
        claseSkateRepository.deleteById(id);
    }

}
