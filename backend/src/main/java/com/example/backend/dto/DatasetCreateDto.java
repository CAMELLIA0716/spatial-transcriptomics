package com.example.backend.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class DatasetCreateDto {
    private String dataId;
    private Long methodId;           // 需要指定方法
    private String technology;
    private String size;
    private Integer spots;
    private Integer genes;
    private String sparsity;
    private String annotation;
    private String type;             // home, nonTypical
    private MultipartFile file;       // 上传的文件（可能是图片或数据文件）
}
