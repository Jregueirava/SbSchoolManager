package com.sbschoolmanager.sbschoolmanager_api.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.time.LocalTime;

@Entity
@Table(name ="HORARIO")
@Getter
@Setter
@NoArgsConstructor
public class Horario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Cod_horario")
    private Integer codHorario;

    @ManyToOne
    @JoinColumn(name = "Cod_ClaseSkate_FK")
    private ClaseSkate claseSkate;

    @Column(name="Dia")
    private String dia;

    @Column(name="Hora")
    private LocalTime hora;
}
