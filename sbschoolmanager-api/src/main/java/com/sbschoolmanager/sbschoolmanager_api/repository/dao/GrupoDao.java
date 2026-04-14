package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Grupo;
import java.util.List;
import java.util.Optional;

public interface GrupoDao {
    List<Grupo> findAll();
    Optional<Grupo> findById(Integer id);
    List<Grupo> findByAlumnoCodAlumno(Integer codAlumno);
    Grupo save(Grupo grupo);
    void deleteById(Integer id);
}
