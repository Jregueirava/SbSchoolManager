package com.sbschoolmanager.sbschoolmanager_api.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;

@Entity
@Table(name ="CLASE_SKATE")
@Getter
@Setter
@NoArgsConstructor
public class ClaseSkate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Cod_ClaseSkate")
    private Integer codClaseSkate;

    @ManyToOne
    @JoinColumn(name = "Cod_Profesor_FK")
    private Profesor profesor;

    @Column(name = "Tipo_ClaseSkate")
    private String tipoClase;

    @Column(name = "Tarifa")
    private BigDecimal tarifa; //Para evitar errores de redondeo con double o float.

}
