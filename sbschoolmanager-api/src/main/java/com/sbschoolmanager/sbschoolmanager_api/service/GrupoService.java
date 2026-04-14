package com.sbschoolmanager.sbschoolmanager_api.service;

import com.sbschoolmanager.sbschoolmanager_api.model.Grupo;
import com.sbschoolmanager.sbschoolmanager_api.repository.GrupoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GrupoService {

    private final GrupoRepository grupoRepository;

    public List<Grupo> obtenerTodos() {
        return grupoRepository.findAll();
    }

    public Optional<Grupo> obtenerPorId(Integer id) {
        return grupoRepository.findById(id);
    }

    public List<Grupo> obtenerPorAlumno(Integer codAlumno) {
        return grupoRepository.findByAlumnoCodAlumno(codAlumno);
    }

    public Grupo guardar(Grupo grupo) {
        return grupoRepository.save(grupo);
    }

    public void eliminar(Integer id) {
        grupoRepository.deleteById(id);
    }
}
