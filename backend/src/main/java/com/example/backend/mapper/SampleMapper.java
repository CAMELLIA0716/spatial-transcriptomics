package com.example.backend.mapper;

import com.example.backend.entity.Sample;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface SampleMapper {
    List<Sample> findAll();
    List<Sample> findByType(String type);
    Sample findBySampleId(String sampleId);
    List<Sample> searchByType(String type, String keyword, int offset, int limit);
    long countByType(String type);
    long countSearchByType(String type, String keyword);
    int insert(Sample sample);
    long countAll();
}