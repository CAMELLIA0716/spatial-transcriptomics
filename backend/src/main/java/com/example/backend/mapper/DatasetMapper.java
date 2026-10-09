package com.example.backend.mapper;

import com.example.backend.entity.Dataset;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface DatasetMapper {
    // 获取所有不同的 data_id，分页
    List<String> findDistinctDataIdByType(@Param("type") String type, @Param("offset") int offset, @Param("limit") int limit);
    long countDistinctDataIdByType(@Param("type") String type);

    // 根据 data_id 和 method_id 查询单条记录
    Dataset findByDataIdAndMethodId(@Param("dataId") String dataId, @Param("methodId") Long methodId);

    // 根据 data_id 查询所有记录（用于获取样本的完整信息）
    List<Dataset> findByDataId(@Param("dataId") String dataId);

    // 根据 data_id 查询任意一条记录（用于获取样本基本信息）
    Dataset findOneByDataId(@Param("dataId") String dataId);

    // 搜索：按 data_id 模糊匹配
    List<String> searchDataIdByType(@Param("type") String type, @Param("keyword") String keyword, @Param("offset") int offset, @Param("limit") int limit);
    long countSearchDataIdByType(@Param("type") String type, @Param("keyword") String keyword);

    void insert(Dataset dataset);
    long countAllDataId(); // 用于总样本数统计
}
