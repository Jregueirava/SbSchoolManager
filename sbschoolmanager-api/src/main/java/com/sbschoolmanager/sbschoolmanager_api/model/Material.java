package com.sbschoolmanager.sbschoolmanager_api.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;

@Entity
@Table(name ="MATERIAL")
@Getter
@Setter
@NoArgsConstructor
public class Material {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Cod_Material")
    private Integer codMaterial;

    @ManyToOne
    @JoinColumn(name= "Cod_alumno_FK")
    private Alumno alumno;

    @Column(name = "Tipo_material")
    private String tipoMaterial;

    @Column(name = "Precio")
    private BigDecimal precio;

    @Column(name = "Tiempo")
    private Integer tiempo;
}
