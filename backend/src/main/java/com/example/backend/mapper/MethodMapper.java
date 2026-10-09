package com.example.backend.mapper;

import com.example.backend.entity.Method;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface MethodMapper {
    List<Method> findBySampleId(@Param("sampleId") String sampleId);
    Method findBySampleIdAndMethodName(@Param("sampleId") String sampleId, @Param("methodName") String methodName);
    long countBySampleId(@Param("sampleId") String sampleId);
    int insert(Method method);
}