package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Alumno;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
//import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository

public class AlumnoDaoImpl implements AlumnoDao {

    @PersistenceContext
    private  EntityManager entityManager;

    @Override
    public List<Alumno> findAll() {
        return entityManager
                .createQuery("SELECT a FROM Alumno a", Alumno.class)
                .getResultList();
    }

    @Override
    public Optional<Alumno> findById(Integer id) {
        return Optional.ofNullable(
                entityManager.find(Alumno.class, id)
        );
    }

    @Override
    public Alumno save(Alumno alumno) {
        if(alumno.getCodAlumno() == null){
            entityManager.persist(alumno);
            return alumno;
        } else{
            return entityManager.merge(alumno);
        }
    }

    @Override
    public void deleteById(Integer id) {
        Alumno alumno = entityManager.find(Alumno.class, id);
        if(alumno != null){
            entityManager.remove(alumno);
        }
    }
}
