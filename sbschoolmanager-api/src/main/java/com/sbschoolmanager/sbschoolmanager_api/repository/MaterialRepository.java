package com.sbschoolmanager.sbschoolmanager_api.repository;

import com.sbschoolmanager.sbschoolmanager_api.model.Material;
import com.sbschoolmanager.sbschoolmanager_api.repository.dao.MaterialDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class MaterialRepository {

    private final MaterialDao materialDao;

    public List<Material> findAll(){
        return materialDao.findAll();
    }

    public Optional<Material> findById(Integer id){
        return materialDao.findById(id);
    }

    public List<Material> findByAlumnoCodAlumno(Integer codAlumno){
        return materialDao.findByAlumnoCodAlumno(codAlumno);
    }

    public Material save(Material material){
        return materialDao.save(material);
    }

    public void deleteById(Integer id){
        materialDao.deleteById(id);
    }
}
