package com.sbschoolmanager.sbschoolmanager_api.repository.dao;

import com.sbschoolmanager.sbschoolmanager_api.model.Horario;
import java.util.List;
import java.util.Optional;

public interface HorarioDao {

    List<Horario> findAll();
    Optional<Horario> findById(Integer id);
    List<Horario> findByClaseSkateCodClaseSkate(Integer codClaseSkate);
    Horario save(Horario horario);
    void delteById(Integer id);

}
