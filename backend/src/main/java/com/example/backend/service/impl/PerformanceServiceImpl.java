package com.example.backend.service.impl;

import com.example.backend.dto.AccuracyDto;
import com.example.backend.dto.PageResponse;
import com.example.backend.dto.PerformanceDto;
import com.example.backend.entity.Performance;
import com.example.backend.mapper.PerformanceMapper;
import com.example.backend.service.PerformanceService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PerformanceServiceImpl implements PerformanceService {

    private final PerformanceMapper performanceMapper;

    @Override
    public PageResponse<PerformanceDto> getPerformanceByDataId(String dataId, int page, int size) {
        // 每个 dataId 只有8条记录，分页意义不大，但保留
        int offset = page * size;
        List<Performance> performances = performanceMapper.findByDataIdWithPagination(dataId, offset, size);
        long total = performanceMapper.countByDataId(dataId);
        List<PerformanceDto> content = performances.stream().map(perf -> {
            PerformanceDto dto = new PerformanceDto();
            dto.setMethodName(perf.getMethodName());
            dto.setNmi(perf.getNmi());
            dto.setHom(perf.getHom());
            dto.setCom(perf.getCom());
            dto.setChaos(perf.getChaos());
            dto.setPas(perf.getPas());
            dto.setAsw(perf.getAsw());
            dto.setMoran(perf.getMoran());
            dto.setGeary(perf.getGeary());
            return dto;
        }).collect(Collectors.toList());
        int totalPages = (int) Math.ceil((double) total / size);
        return new PageResponse<>(content, total, totalPages, page, size);
    }

    @Override
    public List<AccuracyDto> getAccuracyByDataId(String dataId) {
        List<Performance> performances = performanceMapper.getAccuracyByDataId(dataId);
        List<AccuracyDto> list = new ArrayList<>();
        list.add(new AccuracyDto("ground_truth", BigDecimal.valueOf(1.0)));
        for (Performance perf : performances) {
            list.add(new AccuracyDto(perf.getMethodName(), perf.getAccuracyScore()));
        }
        return list;
    }
}
