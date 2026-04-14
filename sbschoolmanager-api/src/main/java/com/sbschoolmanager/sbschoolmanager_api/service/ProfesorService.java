package com.sbschoolmanager.sbschoolmanager_api.service;

import com.sbschoolmanager.sbschoolmanager_api.model.Profesor;
import com.sbschoolmanager.sbschoolmanager_api.repository.ProfesorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProfesorService {

    private final ProfesorRepository profesorRepository;

    public List<Profesor> obtenerTodos(){
        return profesorRepository.findAll();
    }

    public Optional<Profesor> obtenerPorId(Integer id){
        return profesorRepository.findById(id);
    }

    public Profesor guardar(Profesor profesor){
        return profesorRepository.save(profesor);
    }

    public void eliminar(Integer id){
        profesorRepository.deleteById(id);
    }
}
