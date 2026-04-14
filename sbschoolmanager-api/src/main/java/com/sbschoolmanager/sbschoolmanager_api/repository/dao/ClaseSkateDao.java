package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.ClaseSkate;
import java.util.List;
import java.util.Optional;

public interface ClaseSkateDao {
    List<ClaseSkate> findAll();
    Optional<ClaseSkate> findById(Integer id);
    List<ClaseSkate> findByProfesorCodProfesor(Integer codProfesor);
    ClaseSkate save(ClaseSkate claseSkate);
    void deleteById(Integer id);
}
