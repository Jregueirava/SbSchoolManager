package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Profesor;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public class ProfesorDaoImpl implements ProfesorDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Profesor> findAll() {
        return entityManager
                .createQuery("SELECT p FROM Profesor p", Profesor.class)
                .getResultList();
    }

    @Override
    public Optional<Profesor> findById(Integer id) {
        return Optional.ofNullable(
                entityManager.find(Profesor.class, id));
    }

    @Override
    @Transactional
    public Profesor save(Profesor profesor) {
        if(profesor.getCodProfesor()== null){
            entityManager.persist(profesor);
            return profesor;
        } else{
            return entityManager.merge(profesor);
        }
    }

    @Override
    @Transactional
    public void deleteById(Integer id) {
        Profesor profesor = entityManager.find(Profesor.class, id);
        if(profesor !=null){
            entityManager.remove(profesor);
        }
    }
}
