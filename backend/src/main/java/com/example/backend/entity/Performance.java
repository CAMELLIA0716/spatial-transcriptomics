package com.example.backend.entity;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class Performance {
    private Long id;
    private String sampleId;           // 样本ID
    private String methodName;         // 方法名称
    private BigDecimal nmi;
    private BigDecimal hom;
    private BigDecimal com;
    private BigDecimal chaos;
    private BigDecimal pas;
    private BigDecimal asw;
    private BigDecimal moran;
    private BigDecimal geary;
    private BigDecimal accuracyScore;
}
