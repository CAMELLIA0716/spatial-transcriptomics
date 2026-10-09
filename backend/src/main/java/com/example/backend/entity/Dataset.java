package com.example.backend.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Dataset {
    private Long id;
    private String dataId;           // 样本ID
    private Long methodId;
    private String technology;
    private String size;
    private Integer spots;
    private Integer genes;
    private String sparsity;
    private String annotation;
    private String type;             // home, nonTypical
    private String filePathOriginal;
    private String filePathComplex;
    private String dashboardPath;
    private LocalDateTime createdAt;
}
