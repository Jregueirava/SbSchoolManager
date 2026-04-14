package com.sbschoolmanager.sbschoolmanager_api.repository;

import com.sbschoolmanager.sbschoolmanager_api.model.Grupo;
import com.sbschoolmanager.sbschoolmanager_api.repository.dao.GrupoDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class GrupoRepository {

    private final GrupoDao grupoDao;

    public List<Grupo>findAll(){
        return grupoDao.findAll();
    }

    public Optional<Grupo>findById(Integer id){
        return grupoDao.findById(id);
    }

    public List<Grupo> findByAlumnoCodAlumno(Integer codAlumno){
        return grupoDao.findByAlumnoCodAlumno(codAlumno);
    }

    public Grupo save(Grupo grupo){
        return grupoDao.save(grupo);
    }

    public void deleteById(Integer id){
        grupoDao.deleteById(id);
    }
}
