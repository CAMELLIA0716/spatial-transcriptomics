package com.example.backend.dto;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class DifferenceSpotDto {
    private String spotName;
    private BigDecimal consistency;
    private String level;
    private Integer x;
    private Integer y;
}
