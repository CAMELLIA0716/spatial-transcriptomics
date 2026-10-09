package com.example.backend.service.impl;

import com.example.backend.dto.StatsDto;
import com.example.backend.mapper.SampleMapper;
import com.example.backend.mapper.MethodMapper;
import com.example.backend.service.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DashboardServiceImpl implements DashboardService {

    private final MethodMapper methodMapper;
    private final SampleMapper sampleMapper;

    @Override
    public StatsDto getStats() {
        StatsDto stats = new StatsDto();
        // 计算方法总数（每个样本8个方法）
        long sampleCount = sampleMapper.countAll();
        stats.setMethodCount(sampleCount * 8);
        stats.setDatasetCount(sampleCount);
        stats.setSpeciesCount(12L);
        stats.setMetricCount(8L);
        return stats;
    }
}
