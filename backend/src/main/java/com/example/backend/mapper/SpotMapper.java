package com.example.backend.mapper;

import com.example.backend.entity.Spot;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface SpotMapper {
    List<Spot> findByDataId(@Param("dataId") String dataId);
}