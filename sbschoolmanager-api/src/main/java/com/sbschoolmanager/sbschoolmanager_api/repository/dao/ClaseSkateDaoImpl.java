package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.ClaseSkate;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.List;

@Repository
public class ClaseSkateDaoImpl implements ClaseSkateDao{

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<ClaseSkate> findAll() {
        return entityManager
                .createQuery("SELECT c FROM ClaseSkate c", ClaseSkate.class)
                .getResultList();
    }

    @Override
    public Optional<ClaseSkate> findById(Integer id) {
        return Optional.ofNullable(
                entityManager.find(ClaseSkate.class, id)
        );
    }

    @Override
    public List<ClaseSkate> findByProfesorCodProfesor(Integer codProfesor) {
        return entityManager
                .createQuery(
                        "SELECT c FROM ClaseSkate c WHERE c.profesor.codProfesor= :codProfesor", ClaseSkate.class)
                .setParameter("codProfesor", codProfesor)
                .getResultList();
    }

    @Override
    @Transactional
    public ClaseSkate save(ClaseSkate claseSkate) {
        if(claseSkate.getCodClaseSkate()== null){
            entityManager.persist(claseSkate);
            return claseSkate;
        } else{
            return entityManager.merge(claseSkate);
        }
    }

    @Override
    @Transactional
    public void deleteById(Integer id) {
        ClaseSkate claseSkate = entityManager.find(ClaseSkate.class, id);
        if(claseSkate != null){
            entityManager.remove(claseSkate);
        }
    }
}
