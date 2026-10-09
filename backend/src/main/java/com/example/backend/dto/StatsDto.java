package com.example.backend.dto;

import lombok.Data;

@Data
public class StatsDto {
    private long methodCount;
    private long datasetCount;
    private long speciesCount;
    private long metricCount;
}
