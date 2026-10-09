package com.example.backend.mapper;

import com.example.backend.entity.SpotMethodLabel;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface SpotMethodLabelMapper {
    List<SpotMethodLabel> findBySpotId(@Param("spotId") Long spotId);
    List<Map<String, Object>> findLabelsByDataset(@Param("datasetId") Long datasetId); // 返回每个spot的各方法标签
}
