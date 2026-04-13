package com.sbschoolmanager.sbschoolmanager_api.repository;

import com.sbschoolmanager.sbschoolmanager_api.model.Alumno;
import com.sbschoolmanager.sbschoolmanager_api.repository.dao.AlumnoDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class AlumnoRepository {

    private final AlumnoDao alumnoDao;

    public List<Alumno>findAll(){
        return alumnoDao.findAll();
    }

    public Optional<Alumno>findById(Integer id){
        return alumnoDao.findById(id);
    }

    public Alumno save(Alumno alumno){
        return alumnoDao.save(alumno);
    }

    public void deleteById(Integer id){
        alumnoDao.deleteById(id);
    }
}
