package com.sbschoolmanager.sbschoolmanager_api.service;

import com.sbschoolmanager.sbschoolmanager_api.model.Alumno;
import com.sbschoolmanager.sbschoolmanager_api.repository.AlumnoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AlumnoService {

    private final AlumnoRepository alumnoRepository;

    public List<Alumno> obtenerTodos(){
        return alumnoRepository.findAll();
    }

    public Optional<Alumno> obtenerPorId(Integer id){
        return alumnoRepository.findById(id);
    }

    public Alumno guardar(Alumno alumno){
        return alumnoRepository.save(alumno);
    }

    public void eliminar(Integer id){
        alumnoRepository.deleteById(id);
    }
}
