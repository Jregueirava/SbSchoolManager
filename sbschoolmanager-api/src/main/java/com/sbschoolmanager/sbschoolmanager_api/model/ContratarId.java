package com.sbschoolmanager.sbschoolmanager_api.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.io.Serializable;

@Embeddable
@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode
public class ContratarId implements Serializable{
    @Column(name="Cod_alumno_FK")
    private Integer codAlumno;

    @Column(name = "Cod_ClaseSkate_FK")
    private Integer codClaseSkate;
}
