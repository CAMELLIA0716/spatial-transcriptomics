package com.example.backend.dto;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class PerformanceDto {
    private String methodName;
    private BigDecimal nmi;
    private BigDecimal hom;
    private BigDecimal com;
    private BigDecimal chaos;
    private BigDecimal pas;
    private BigDecimal asw;
    private BigDecimal moran;
    private BigDecimal geary;
}
