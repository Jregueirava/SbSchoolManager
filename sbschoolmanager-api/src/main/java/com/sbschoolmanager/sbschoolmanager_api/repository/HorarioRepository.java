package com.sbschoolmanager.sbschoolmanager_api.repository;

import com.sbschoolmanager.sbschoolmanager_api.model.Horario;
import com.sbschoolmanager.sbschoolmanager_api.repository.dao.HorarioDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class HorarioRepository {

    private final HorarioDao horarioDao;

    public List<Horario> findAll(){
        return horarioDao.findAll();
    }

    public Optional<Horario> findById(Integer id){
        return horarioDao.findById(id);
    }

    public List<Horario> findByClaseSkateCodClaseSkate(Integer codClaseSkate){
        return horarioDao.findByClaseSkateCodClaseSkate(codClaseSkate);
    }

    public Horario save(Horario horario){
        return horarioDao.save(horario);
    }

    public void deleteById(Integer id){
        horarioDao.delteById(id);
    }
}
