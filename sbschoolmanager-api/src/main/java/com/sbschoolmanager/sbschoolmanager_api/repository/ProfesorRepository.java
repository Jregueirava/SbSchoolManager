package com.sbschoolmanager.sbschoolmanager_api.repository;

import com.sbschoolmanager.sbschoolmanager_api.model.Profesor;
import com.sbschoolmanager.sbschoolmanager_api.repository.dao.ProfesorDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class ProfesorRepository {

    private final ProfesorDao profesorDao;

    public List<Profesor> findAll(){
        return profesorDao.findAll();
    }

    public Optional<Profesor> findById(Integer id){
        return profesorDao.findById(id);
    }

    public Profesor save(Profesor profesor){
        return profesorDao.save(profesor);
    }

    public void deleteById(Integer id){
        profesorDao.deleteById(id);
    }
}
