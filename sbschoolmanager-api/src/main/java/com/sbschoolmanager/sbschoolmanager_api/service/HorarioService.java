package com.sbschoolmanager.sbschoolmanager_api.service;

import com.sbschoolmanager.sbschoolmanager_api.model.Horario;
import com.sbschoolmanager.sbschoolmanager_api.repository.HorarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class HorarioService {

    private final HorarioRepository horarioRepository;

    public List<Horario> obtenerTodos() {
        return horarioRepository.findAll();
    }

    public Optional<Horario> obtenerPorId(Integer id) {
        return horarioRepository.findById(id);
    }

    public List<Horario> obtenerPorClase(Integer codClaseSkate) {
        return horarioRepository.findByClaseSkateCodClaseSkate(codClaseSkate);
    }

    public Horario guardar(Horario horario) {
        return horarioRepository.save(horario);
    }

    public void eliminar(Integer id) {
        horarioRepository.deleteById(id);
    }

}
