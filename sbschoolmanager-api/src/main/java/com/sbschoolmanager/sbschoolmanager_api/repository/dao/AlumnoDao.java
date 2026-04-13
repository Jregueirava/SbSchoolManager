package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Alumno;
import java.util.List;
import java.util.Optional;

public interface AlumnoDao {
    List<Alumno> findAll();
    Optional<Alumno> findById(Integer id);
    Alumno save(Alumno alumno);
    void deleteById(Integer id);
}
