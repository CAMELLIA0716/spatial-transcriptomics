package com.example.backend.entity;

import lombok.Data;

@Data
public class SpotMethodLabel {
    private Long id;
    private Long spotId;
    private Long methodId;
    private String label;
}
