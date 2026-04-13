package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Profesor;
import java.util.List;
import java.util.Optional;

public interface ProfesorDao {
    List<Profesor> findAll();
    Optional<Profesor> findById(Integer id);
    Profesor save(Profesor profesor);
    void deleteById(Integer id);
}
