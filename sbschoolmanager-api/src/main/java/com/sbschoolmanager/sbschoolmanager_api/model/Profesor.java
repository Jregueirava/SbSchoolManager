package com.sbschoolmanager.sbschoolmanager_api.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

@Entity
@Table(name ="PROFESOR")
@Getter
@Setter
@NoArgsConstructor
public class Profesor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name =" Cod_Profesor")
    private Integer codProfesor;

    @Column(name= "Nom_CC")
    private String nombre;

    @Column(name= "Ap_profesor")
    private String apellido;

    @Column(name= "DNI_profesor")
    private String dni;

    @Column(name = "Años_experiencia")
    private Integer anosExperiencia;
}
