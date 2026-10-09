package com.example.backend.entity;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class Spot {
    private Long id;
    private String sampleId;           // 样本ID
    private String spotName;
    private Integer xCoord;
    private Integer yCoord;
    private BigDecimal consistencyScore;
    private String complexityLevel; // High, Medium, Low
}
