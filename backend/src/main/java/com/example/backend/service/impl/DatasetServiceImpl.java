package com.example.backend.service.impl;

import com.example.backend.dto.DatasetCreateDto;
import com.example.backend.dto.DatasetDto;
import com.example.backend.dto.PageResponse;
import com.example.backend.entity.Sample;
import com.example.backend.entity.Method;
import com.example.backend.mapper.SampleMapper;
import com.example.backend.mapper.MethodMapper;
import com.example.backend.service.DatasetService;
import com.example.backend.util.FileStorageUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

@Service
@RequiredArgsConstructor
public class DatasetServiceImpl implements DatasetService {

    private final SampleMapper sampleMapper;
    private final MethodMapper methodMapper;
    private final FileStorageUtil fileStorageUtil;

    @Override
    public PageResponse<DatasetDto> getDatasets(String type, String search, int page, int size) {
        int offset = page * size;
        List<Sample> samples;
        long total;
        if (search != null && !search.trim().isEmpty()) {
            samples = sampleMapper.searchByType(type, search, offset, size);
            total = sampleMapper.countSearchByType(type, search);
        } else {
            samples = sampleMapper.findByType(type);
            total = sampleMapper.countByType(type);
        }

        List<DatasetDto> content = new ArrayList<>();
        for (Sample sample : samples) {
            DatasetDto dto = new DatasetDto();
            dto.setDataId(sample.getSampleId());
            dto.setTechnology(sample.getTechnology());
            dto.setSize(sample.getSize());
            dto.setSpots(sample.getSpots());
            dto.setGenes(sample.getGenes());
            dto.setSparsity(sample.getSparsity());
            dto.setAnnotation(sample.getAnnotation());
            dto.setType(sample.getType());
            content.add(dto);
        }
        int totalPages = (int) Math.ceil((double) total / size);
        return new PageResponse<>(content, total, totalPages, page, size);
    }

    @Override
    @Transactional
    public DatasetDto createDataset(DatasetCreateDto dto) {
        // 创建样本
        Sample sample = new Sample();
        sample.setSampleId(dto.getDataId());
        sample.setTechnology(dto.getTechnology());
        sample.setSize(dto.getSize());
        sample.setSpots(dto.getSpots());
        sample.setGenes(dto.getGenes());
        sample.setSparsity(dto.getSparsity());
        sample.setAnnotation(dto.getAnnotation());
        sample.setType(dto.getType());
        sample.setDashboardPath(dto.getDataId() + "_dashboard.html");

        sampleMapper.insert(sample);

        // 为样本创建8个方法
        List<String> methodNames = List.of("STAIG", "STAGATE", "GraphST", "DeepST", "CCST", "SpaGCN", "conST", "spaceflow");
        List<BigDecimal> weights = List.of(
            new BigDecimal("0.7818"), new BigDecimal("0.7131"), new BigDecimal("0.7124"),
            new BigDecimal("0.6649"), new BigDecimal("0.6594"), new BigDecimal("0.5643"),
            new BigDecimal("0.4885"), new BigDecimal("0.4839")
        );

        for (int i = 0; i < methodNames.size(); i++) {
            Method method = new Method();
            method.setSampleId(dto.getDataId());
            method.setMethodName(methodNames.get(i));
            method.setWeight(weights.get(i));
            methodMapper.insert(method);
        }

        return convertToDto(sample);
    }

    private DatasetDto convertToDto(Sample entity) {
        DatasetDto dto = new DatasetDto();
        dto.setDataId(entity.getSampleId());
        dto.setTechnology(entity.getTechnology());
        dto.setSize(entity.getSize());
        dto.setSpots(entity.getSpots());
        dto.setGenes(entity.getGenes());
        dto.setSparsity(entity.getSparsity());
        dto.setAnnotation(entity.getAnnotation());
        dto.setType(entity.getType());
        return dto;
    }
}
