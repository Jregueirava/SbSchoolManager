package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Horario;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;


@Repository
public class HorarioDaoImpl implements HorarioDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Horario> findAll() {
        return entityManager
                .createQuery("SELECT h FROM Horario h", Horario.class)
                .getResultList();
    }

    @Override
    public Optional<Horario> findById(Integer id) {
        return Optional.ofNullable(
                entityManager.find(Horario.class, id)
        );
    }

    @Override
    public List<Horario> findByClaseSkateCodClaseSkate(Integer codClaseSkate) {
        return entityManager
                .createQuery("SELECT h FROM Horario h WHERE h.claseSkate.codClaseSkate= :codClaseSkate", Horario.class)
                .setParameter("codClaseSkate", codClaseSkate)
                .getResultList();
    }

    @Override
    @Transactional
    public Horario save(Horario horario) {
        if(horario.getCodHorario()== null){
            entityManager.persist(horario);
            return horario;
        } else{
            return entityManager.merge(horario);
        }
    }

    @Override
    @Transactional
    public void delteById(Integer id) {
        Horario horario = entityManager.find(Horario.class, id);
        if(horario != null){
            entityManager.remove(horario);
        }
    }
}
