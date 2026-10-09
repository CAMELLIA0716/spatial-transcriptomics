package com.example.backend.controller;

import com.example.backend.entity.Method;
import com.example.backend.mapper.MethodMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/api/files")
@RequiredArgsConstructor
public class FileController {

    private final MethodMapper methodMapper;

    @Value("${data.root-dir}")
    private String dataRootDir;

    /**
     * 获取原始聚类图
     * @param dataId 样本ID
     * @param methodName 方法名称
     */
    @GetMapping("/original/{dataId}/{methodName}")
    public ResponseEntity<Resource> getOriginalPlot(@PathVariable String dataId, @PathVariable String methodName) throws IOException {
        Method method = methodMapper.findBySampleIdAndMethodName(dataId, methodName);
        if (method == null || method.getFilePathOriginal() == null) {
            return ResponseEntity.notFound().build();
        }
        
        // 从数据库路径中提取相对路径，然后与配置的根目录拼接
        Path filePath = resolveFilePath(method.getFilePathOriginal());
        return serveFile(filePath);
    }

    /**
     * 获取带复杂标记的聚类图
     */
    @GetMapping("/complex/{dataId}/{methodName}")
    public ResponseEntity<Resource> getComplexPlot(@PathVariable String dataId, @PathVariable String methodName) throws IOException {
        Method method = methodMapper.findBySampleIdAndMethodName(dataId, methodName);
        if (method == null || method.getFilePathComplex() == null) {
            return ResponseEntity.notFound().build();
        }
        
        Path filePath = resolveFilePath(method.getFilePathComplex());
        return serveFile(filePath);
    }

    /**
     * 获取 Dashboard HTML
     */
    @GetMapping("/dashboard/{dataId}")
    public ResponseEntity<Resource> getDashboard(@PathVariable String dataId) throws IOException {
        String dashboardFileName = dataId + "_dashboard.html";
        // 使用配置的根目录拼接路径
        Path filePath = Paths.get(dataRootDir).resolve("METHODS").resolve(dashboardFileName);
        if (!Files.exists(filePath)) {
            return ResponseEntity.notFound().build();
        }
        Resource resource = new FileSystemResource(filePath.toFile());
        return ResponseEntity.ok()
                .contentType(MediaType.TEXT_HTML)
                .body(resource);
    }

    /**
     * 解析文件路径 - 支持绝对路径和相对路径
     */
    private Path resolveFilePath(String dbPath) {
        // 统一使用正斜杠
        String normalizedPath = dbPath.replace("\\", "/");
        
        // 如果是绝对路径，尝试提取相对于 METHODS 目录的相对路径
        if (normalizedPath.contains(":") || normalizedPath.startsWith("/")) {
            // 查找路径中是否包含 "METHODS"
            int methodsIndex = normalizedPath.indexOf("/METHODS/");
            if (methodsIndex != -1) {
                // 提取 METHODS 之后的相对路径
                String relativePath = normalizedPath.substring(methodsIndex + 1);
                return Paths.get(dataRootDir, relativePath.split("/"));
            }
        }
        
        // 如果是相对路径，直接与根目录拼接
        String[] parts = normalizedPath.split("/");
        return Paths.get(dataRootDir, parts);
    }

    private ResponseEntity<Resource> serveFile(Path filePath) throws IOException {
        if (!Files.exists(filePath)) {
            return ResponseEntity.notFound().build();
        }
        Resource resource = new FileSystemResource(filePath.toFile());
        String contentType = Files.probeContentType(filePath);
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .body(resource);
    }
}
