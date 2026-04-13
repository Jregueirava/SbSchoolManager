package com.sbschoolmanager.sbschoolmanager_api.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

@Entity
@Table(name ="GRUPO")
@Getter
@Setter
@NoArgsConstructor
public class Grupo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="Cod_grupo")
    private Integer codGrupo;

    @ManyToOne
    @JoinColumn(name = "Cod_alumno_FK")
    private Alumno alumno; //Guardo el objeto entero, en vez del número.

    @Column(name = "Nivel")
    private String nivel;
}
