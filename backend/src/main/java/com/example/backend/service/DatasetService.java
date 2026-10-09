package com.example.backend.service;

import com.example.backend.dto.DatasetCreateDto;
import com.example.backend.dto.DatasetDto;
import com.example.backend.dto.PageResponse;

public interface DatasetService {
    PageResponse<DatasetDto> getDatasets(String type, String search, int page, int size);
    DatasetDto createDataset(DatasetCreateDto dto);
}
