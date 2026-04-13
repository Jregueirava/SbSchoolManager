package com.sbschoolmanager.sbschoolmanager_api.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Entity
@Table(name = "CONTRATAR")
@Getter
@Setter
@NoArgsConstructor
public class Contratar {

    @EmbeddedId
    private ContratarId id;

    @ManyToOne
    @MapsId("codAlumno")
    @JoinColumn(name = "Cod_alumno_FK")
    private Alumno alumno;

    @ManyToOne
    @MapsId("codClaseSkate")
    @JoinColumn(name = "Cod_ClaseSkate_FK")
    private ClaseSkate claseSkate;

    @Column(name = "Fecha_Inicio")
    private LocalDate fechaIncio;

    @Column(name = "Fecha_Fin")
    private LocalDate fechaFin;
}
