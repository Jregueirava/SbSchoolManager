package com.sbschoolmanager.sbschoolmanager_api.service;

import com.sbschoolmanager.sbschoolmanager_api.model.Material;
import com.sbschoolmanager.sbschoolmanager_api.repository.MaterialRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MaterialService {

    private final MaterialRepository materialRepository;

    public List<Material> obtenerTodos() {
        return materialRepository.findAll();
    }

    public Optional<Material> obtenerPorId(Integer id) {
        return materialRepository.findById(id);
    }

    public List<Material> obtenerPorAlumno(Integer codAlumno) {
        return materialRepository.findByAlumnoCodAlumno(codAlumno);
    }

    public Material guardar(Material material) {
        return materialRepository.save(material);
    }

    public void eliminar(Integer id) {
        materialRepository.deleteById(id);
    }

}
