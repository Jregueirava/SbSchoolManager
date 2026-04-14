package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Grupo;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public class GrupoDaoImpl implements GrupoDao{

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Grupo> findAll() {
        return entityManager
                .createQuery("SELECT g FROM Grupo g", Grupo.class)
                .getResultList();
    }

    @Override
    public Optional<Grupo> findById(Integer id) {
        return Optional.ofNullable(
                entityManager.find(Grupo.class, id)
        );
    }

    @Override
    public List<Grupo> findByAlumnoCodAlumno(Integer codAlumno) {
        return entityManager
                .createQuery(
                        "SELECT g FROM g WHERE g.alumno.codAlumno = :codAlumno", Grupo.class)
                .setParameter("codAlumno", codAlumno)
                .getResultList();
    }

    @Override
    @Transactional
    public Grupo save(Grupo grupo) {
        if(grupo.getCodGrupo()== null){
            entityManager.persist(grupo);
            return grupo;
        } else{
            return entityManager.merge(grupo);
        }
    }

    @Override
    @Transactional
    public void deleteById(Integer id) {
        Grupo grupo = entityManager.find(Grupo.class, id);
        if(grupo !=null){
            entityManager.remove(grupo);
        }
    }
}
