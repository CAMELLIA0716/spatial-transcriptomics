package com.example.backend.service;

import com.example.backend.dto.AccuracyDto;
import com.example.backend.dto.PageResponse;
import com.example.backend.dto.PerformanceDto;

import java.util.List;

public interface PerformanceService {
    PageResponse<PerformanceDto> getPerformanceByDataId(String dataId, int page, int size);
    List<AccuracyDto> getAccuracyByDataId(String dataId);
}
