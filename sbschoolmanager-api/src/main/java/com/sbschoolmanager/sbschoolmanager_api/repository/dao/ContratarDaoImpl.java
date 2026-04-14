package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Contratar;
import com.sbschoolmanager.sbschoolmanager_api.model.ContratarId;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public class ContratarDaoImpl implements ContratarDao{

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Contratar> findAll() {
        return entityManager
                .createQuery("SELECT c FROM Contratar c", Contratar.class)
                .getResultList();
    }

    @Override
    public Optional<Contratar> findById(ContratarId id) {
        return Optional.ofNullable(
                entityManager.find(Contratar.class, id)
        );
    }

    @Override
    public List<Contratar> findByAlumnoCodAlumno(Integer codAlumno) {
        return entityManager
                .createQuery("SELECT c FROM Contratar c WHERE c.alumno.coAlumno = :codAlumno",
                        Contratar.class)
                .setParameter("codAlumno", codAlumno)
                .getResultList();
    }

    @Override
    @Transactional
    public Contratar save(Contratar contratar) {
        return entityManager.merge(contratar);
    }
}
