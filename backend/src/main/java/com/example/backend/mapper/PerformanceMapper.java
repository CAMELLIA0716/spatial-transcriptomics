package com.example.backend.mapper;

import com.example.backend.entity.Performance;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface PerformanceMapper {
    List<Performance> findByDataId(@Param("dataId") String dataId);
    List<Performance> findByDataIdWithPagination(@Param("dataId") String dataId, @Param("offset") int offset, @Param("limit") int limit);
    long countByDataId(@Param("dataId") String dataId);
    List<Performance> getAccuracyByDataId(@Param("dataId") String dataId);
}