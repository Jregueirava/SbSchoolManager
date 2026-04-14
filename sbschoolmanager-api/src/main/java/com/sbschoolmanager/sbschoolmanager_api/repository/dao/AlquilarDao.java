package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Alquilar;
import com.sbschoolmanager.sbschoolmanager_api.model.AlquilarId;
import java.util.List;
import java.util.Optional;

public interface AlquilarDao {
    List<Alquilar> findAll();
    Optional<Alquilar> findById(AlquilarId id);
    List<Alquilar>  findByAlumnoCodAlumno(Integer codAlumno);
    Alquilar save(Alquilar alquilar);
}
