package com.example.backend.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Sample {
    private String sampleId;           // 样本ID
    private String technology;
    private String size;
    private Integer spots;
    private Integer genes;
    private String sparsity;
    private String annotation;
    private String type;             // home, nonTypical
    private String dashboardPath;
    private LocalDateTime createdAt;
}