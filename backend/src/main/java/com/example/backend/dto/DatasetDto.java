package com.example.backend.dto;

import lombok.Data;

@Data
public class DatasetDto {
    private String dataId;          // 样本ID
    private String technology;
    private String size;
    private Integer spots;
    private Integer genes;
    private String sparsity;
    private String annotation;
    private String type;
}
