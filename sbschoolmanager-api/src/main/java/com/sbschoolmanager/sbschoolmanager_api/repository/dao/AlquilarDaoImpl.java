package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Alquilar;
import com.sbschoolmanager.sbschoolmanager_api.model.AlquilarId;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class AlquilarDaoImpl implements AlquilarDao{

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Alquilar> findAll() {
        return entityManager
                .createQuery("SELECT a FROM Alquilar a", Alquilar.class)
                .getResultList();
    }

    @Override
    public Optional<Alquilar> findById(AlquilarId id) {
        return Optional.ofNullable(
                entityManager.find(Alquilar.class, id)
        );
    }

    @Override
    public List<Alquilar> findByAlumnoCodAlumno(Integer codAlumno) {
        return entityManager
                .createQuery(
                        "SELECT a FROM Alquilar a WHERE a.alumno.codAlumno = :codAlumno", Alquilar.class)
                .setParameter("codAlumno", codAlumno)
                .getResultList();
    }

    @Override
    public Alquilar save(Alquilar alquilar) {
        return entityManager.merge(alquilar); // Al ser clave compuesta se usa merge, jpa gestiona si es insert o update por la clave(existente o no)
    }
}
