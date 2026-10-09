package com.example.backend.controller;

import com.example.backend.dto.AccuracyDto;
import com.example.backend.dto.PageResponse;
import com.example.backend.dto.PerformanceDto;
import com.example.backend.service.PerformanceService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/samples/{dataId}")
@RequiredArgsConstructor
public class PerformanceController {

    private final PerformanceService performanceService;

    @GetMapping("/performance")
    public PageResponse<PerformanceDto> getPerformance(
            @PathVariable String dataId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size) {
        return performanceService.getPerformanceByDataId(dataId, page, size);
    }

    @GetMapping("/accuracy")
    public List<AccuracyDto> getAccuracy(@PathVariable String dataId) {
        return performanceService.getAccuracyByDataId(dataId);
    }
}
