package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Material;
import java.util.List;
import java.util.Optional;

public interface MaterialDao {
    List<Material> findAll();
    Optional<Material> findById(Integer id);
    List<Material> findByAlumnoCodAlumno(Integer codAlumno);
    Material save(Material material);
    void deleteById(Integer id);
}
