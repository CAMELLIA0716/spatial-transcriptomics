package com.example.backend.service;

import com.example.backend.dto.DifferenceSpotDto;
import java.util.List;

public interface DifferenceService {
    List<DifferenceSpotDto> getDifferenceSpots(String dataId);
}
