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
public class AlquilarId implements Serializable {
    @Column(name = "Cod_Material_FK")
    private Integer codMaterial;

    @Column(name = "Cod_alumno_FK")
    private Integer codAlumno;
}
