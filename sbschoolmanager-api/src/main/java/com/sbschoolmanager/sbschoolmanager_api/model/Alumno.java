package com.sbschoolmanager.sbschoolmanager_api.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

@Entity
@Table(name="ALUMNO")
@Getter
@Setter
@NoArgsConstructor
public class Alumno {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name= "Cod_alumno")
    private Integer codAlumno;

    @Column(name="Nom_alumno_CC")
    private String nombre;

    @Column(name="Ap_alumno")
    private String apellido;

    @Column(name="DNI_alumno")
    private String dni;

    @Column(name = "Edad")
    private Integer edad;

    @Column(name = "Datos_Padres_OP")
    private String datosPadres;
}
