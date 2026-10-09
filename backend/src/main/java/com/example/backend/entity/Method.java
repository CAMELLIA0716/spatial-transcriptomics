package com.example.backend.entity;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class Method {
    private Long id;
    private String sampleId;           // 样本ID
    private String methodName;         // 方法名称
    private BigDecimal weight;
    private String filePathOriginal;
    private String filePathComplex;
    private LocalDateTime createdAt;
}
