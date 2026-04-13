package com.sbschoolmanager.sbschoolmanager_api.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Entity
@Table(name = "ALQUILAR")
@Getter
@Setter
@NoArgsConstructor
public class Alquilar {

    @EmbeddedId
    private AlquilarId id;

    @ManyToOne
    @MapsId("codMaterial")
    @JoinColumn(name="Cod_Material_FK")
    private Material material;

    @ManyToOne
    @MapsId("codAlumno")
    @JoinColumn(name = "Cod_alumno_FK")
    private Alumno alumno;

    @Column(name = "Fecha_Inicio")
    private LocalDate fechaInicio;

    @Column(name = "Fecha_Fin")
    private LocalDate fechaFin;
}
