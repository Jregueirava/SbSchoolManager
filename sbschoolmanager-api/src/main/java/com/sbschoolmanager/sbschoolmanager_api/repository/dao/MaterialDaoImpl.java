package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Material;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public class MaterialDaoImpl implements MaterialDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Material> findAll() {
        return entityManager
                .createQuery("SELECT m FROM Material m", Material.class)
                .getResultList();
    }

    @Override
    public Optional<Material> findById(Integer id) {
        return Optional.ofNullable(
                entityManager.find(Material.class, id)
        );
    }

    @Override
    public List<Material> findByAlumnoCodAlumno(Integer codAlumno) {
        return entityManager
                .createQuery(
                        "SELECT m FROM Material m WHERE m.alumno.codAlumno = :codAlumno ", Material.class)
                .setParameter("codAlumno", codAlumno)
                .getResultList();
    }

    @Override
    @Transactional
    public Material save(Material material) {
        if(material.getCodMaterial() == null){
            entityManager.persist(material);
            return material;
        } else{
            return entityManager.merge(material);
        }
    }

    @Override
    @Transactional
    public void deleteById(Integer id) {
        Material material = entityManager.find(Material.class, id);
        if(material != null){
            entityManager.remove(material);
        }
    }
}
