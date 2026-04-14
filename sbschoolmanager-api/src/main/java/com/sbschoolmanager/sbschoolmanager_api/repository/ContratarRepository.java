package com.sbschoolmanager.sbschoolmanager_api.repository;

import ch.qos.logback.core.joran.spi.ConsoleTarget;
import com.sbschoolmanager.sbschoolmanager_api.model.Contratar;
import com.sbschoolmanager.sbschoolmanager_api.model.ContratarId;
import com.sbschoolmanager.sbschoolmanager_api.repository.dao.ContratarDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;


@Component
@RequiredArgsConstructor
public class ContratarRepository {

    private final ContratarDao contratarDao;

    public List<Contratar> findAll(){
        return contratarDao.findAll();
    }

    public Optional<Contratar> findById(ContratarId id){
        return contratarDao.findById(id);
    }

    public List<Contratar> findByAlumnoCodAlumno(Integer codAlumno){
        return contratarDao.findByAlumnoCodAlumno(codAlumno);
    }

    public Contratar save(Contratar contratar){
        return contratarDao.save(contratar);
    }
}
