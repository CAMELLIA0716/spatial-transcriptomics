package com.example.backend.controller;

import com.example.backend.dto.DatasetCreateDto;
import com.example.backend.dto.DatasetDto;
import com.example.backend.dto.PageResponse;
import com.example.backend.service.DatasetService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/datasets")
@RequiredArgsConstructor
public class DatasetController {

    private final DatasetService datasetService;

    @GetMapping
    public PageResponse<DatasetDto> getDatasets(
            @RequestParam(defaultValue = "home") String type,
            @RequestParam(required = false) String search,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size) {
        return datasetService.getDatasets(type, search, page, size);
    }

    @PostMapping(consumes = {"multipart/form-data"})
    @ResponseStatus(HttpStatus.CREATED)
    public DatasetDto createDataset(@ModelAttribute DatasetCreateDto dto) {
        return datasetService.createDataset(dto);
    }
}
