package com.sbschoolmanager.sbschoolmanager_api.repository;

import com.sbschoolmanager.sbschoolmanager_api.model.Alquilar;
import com.sbschoolmanager.sbschoolmanager_api.model.AlquilarId;
import com.sbschoolmanager.sbschoolmanager_api.repository.dao.AlquilarDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class AlquilarRepository {

    private final AlquilarDao alquilarDao;

    public List<Alquilar> findAll(){
        return alquilarDao.findAll();
    }

    public Optional<Alquilar> findById(AlquilarId id){
        return alquilarDao.findById(id);
    }

    public List<Alquilar> findByAlumnoCodAlumno(Integer codAlumno){
        return alquilarDao.findByAlumnoCodAlumno(codAlumno);
    }

    public Alquilar save(Alquilar  alquilar){
        return alquilarDao.save(alquilar);
    }

}
