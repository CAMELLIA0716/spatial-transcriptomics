package com.example.backend.controller;

import com.example.backend.dto.DifferenceSpotDto;
import com.example.backend.service.DifferenceService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/samples/{dataId}")
@RequiredArgsConstructor
public class DifferenceController {

    private final DifferenceService differenceService;

    @GetMapping("/difference-spots")
    public List<DifferenceSpotDto> getDifferenceSpots(@PathVariable String dataId) {
        return differenceService.getDifferenceSpots(dataId);
    }
}
