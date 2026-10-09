package com.example.backend.service.impl;

import com.example.backend.dto.DifferenceSpotDto;
import com.example.backend.entity.Spot;
import com.example.backend.mapper.SpotMapper;
import com.example.backend.service.DifferenceService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DifferenceServiceImpl implements DifferenceService {

    private final SpotMapper spotMapper;

    @Override
    public List<DifferenceSpotDto> getDifferenceSpots(String dataId) {
        List<Spot> spots = spotMapper.findByDataId(dataId);
        return spots.stream().map(spot -> {
            DifferenceSpotDto dto = new DifferenceSpotDto();
            dto.setSpotName(spot.getSpotName());
            dto.setConsistency(spot.getConsistencyScore());
            dto.setLevel(spot.getComplexityLevel());
            dto.setX(spot.getXCoord());
            dto.setY(spot.getYCoord());
            return dto;
        }).collect(Collectors.toList());
    }
}
