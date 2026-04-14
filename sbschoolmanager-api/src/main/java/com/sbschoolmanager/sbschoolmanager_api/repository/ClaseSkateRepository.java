package com.sbschoolmanager.sbschoolmanager_api.repository;

import com.sbschoolmanager.sbschoolmanager_api.model.ClaseSkate;
import com.sbschoolmanager.sbschoolmanager_api.repository.dao.ClaseSkateDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class ClaseSkateRepository {

    private final ClaseSkateDao claseSkateDao;

    public List<ClaseSkate> findAll(){
        return claseSkateDao.findAll();
    }

    public Optional<ClaseSkate> findById(Integer id){
        return claseSkateDao.findById(id);
    }

    public List<ClaseSkate> findByProfesorCodProfesor(Integer codProfesor){
        return claseSkateDao.findByProfesorCodProfesor(codProfesor);
    }

    public ClaseSkate save(ClaseSkate claseSkate){
        return claseSkateDao.save(claseSkate);
    }

    public void deleteById(Integer id){
        claseSkateDao.deleteById(id);
    }
}
