package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Contratar;
import com.sbschoolmanager.sbschoolmanager_api.model.ContratarId;

import java.awt.*;
import java.util.List;
import java.util.Optional;

public interface ContratarDao {
    List<Contratar> findAll();
    Optional<Contratar>findById(ContratarId id);
    List<Contratar> findByAlumnoCodAlumno(Integer codAlumno);
    Contratar save(Contratar contratar);
}
