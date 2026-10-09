#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
数据库插入脚本生成器
支持生成绝对路径或相对路径的SQL语句
"""

import os
import sys
import argparse
import pandas as pd


def generate_sql(use_relative_path=False, data_root_dir=None):
    """
    生成SQL插入语句
    
    Args:
        use_relative_path: 是否使用相对路径
        data_root_dir: 数据根目录（用于计算相对路径）
    """
    # 获取当前目录
    current_dir = os.getcwd()
    print(f"当前目录: {current_dir}")
    
    # 获取所有 csv 结果文件和 report.txt 文件
    csv_files = [f for f in os.listdir(current_dir) if f.endswith('_results.csv')]
    csv_files.sort()
    
    report_files = [f for f in os.listdir(current_dir) if f.endswith('_report.txt')]
    report_files.sort()
    
    # 存储样本信息
    sample_info = {}
    spot_data = {}
    
    # 从 csv 文件中获取样本信息和 spot 数据
    for csv_file in csv_files:
        # 提取样本 ID
        sample_id = csv_file.split('_')[0]
        
        # 读取 csv 文件
        df = pd.read_csv(csv_file)
        
        # 获取 spots 数量
        spots_count = len(df)
        
        # 按照 consistency_score 从低到高排序
        df_sorted = df.sort_values('consistency_score', ascending=True)
        
        # 取前 10 个
        top_10_spots = df_sorted.head(10)
        
        # 存储样本信息
        sample_info[sample_id] = spots_count
        
        # 存储 spot 数据
        spot_data[sample_id] = top_10_spots
    
    # 确保所有 report.txt 文件对应的样本都被包含
    for report_file in report_files:
        sample_id = report_file.split('_')[0]
        if sample_id not in sample_info:
            sample_info[sample_id] = 0
            spot_data[sample_id] = pd.DataFrame()
    
    # 方法列表
    methods = ['CCST', 'conST', 'DeepST', 'GraphST', 'spaceflow', 'SpaGCN', 'STAGATE', 'STAIG']
    
    # 生成 SQL 文件
    output_file = 'insert_data.sql'
    with open(output_file, 'w', encoding='utf-8-sig') as f:
        # 写入注释
        f.write("-- ============================================\n")
        f.write("-- Spatial Transcriptomics 数据库初始化脚本\n")
        f.write("-- ============================================\n")
        f.write(f"-- 生成时间: {pd.Timestamp.now()}\n")
        f.write(f"-- 路径模式: {'相对路径' if use_relative_path else '绝对路径'}\n")
        f.write("-- ============================================\n\n")
        
        # 创建表
        f.write("-- ============================================\n")
        f.write("-- 创建数据表\n")
        f.write("-- ============================================\n\n")
        
        # 样本表
        f.write("-- 样本表\n")
        f.write("CREATE TABLE IF NOT EXISTS sample (\n")
        f.write("    sample_id VARCHAR(50) PRIMARY KEY COMMENT '样本ID',\n")
        f.write("    technology VARCHAR(50) NOT NULL,\n")
        f.write("    size VARCHAR(20),\n")
        f.write("    spots INT,\n")
        f.write("    genes INT,\n")
        f.write("    sparsity VARCHAR(10),\n")
        f.write("    annotation VARCHAR(255),\n")
        f.write("    type ENUM('home','nonTypical') DEFAULT 'home',\n")
        f.write("    dashboard_path VARCHAR(255) COMMENT 'dashboard路径',\n")
        f.write("    created_at DATETIME DEFAULT CURRENT_TIMESTAMP\n")
        f.write(") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\n\n")
        
        # 方法表
        f.write("-- 方法表\n")
        f.write("CREATE TABLE IF NOT EXISTS method (\n")
        f.write("    id BIGINT PRIMARY KEY AUTO_INCREMENT,\n")
        f.write("    sample_id VARCHAR(50) NOT NULL COMMENT '样本ID',\n")
        f.write("    method_name VARCHAR(50) NOT NULL COMMENT '方法名称',\n")
        f.write("    weight DECIMAL(5,4) COMMENT '权重',\n")
        f.write("    file_path_original VARCHAR(255) COMMENT '原始聚类图路径',\n")
        f.write("    file_path_complex VARCHAR(255) COMMENT '复杂标记图路径',\n")
        f.write("    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,\n")
        f.write("    FOREIGN KEY (sample_id) REFERENCES sample(sample_id) ON DELETE CASCADE,\n")
        f.write("    UNIQUE KEY uk_sample_method (sample_id, method_name)\n")
        f.write(") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\n\n")
        
        # 性能表
        f.write("-- 性能指标表\n")
        f.write("CREATE TABLE IF NOT EXISTS performance (\n")
        f.write("    id BIGINT PRIMARY KEY AUTO_INCREMENT,\n")
        f.write("    sample_id VARCHAR(50) NOT NULL COMMENT '样本ID',\n")
        f.write("    method_name VARCHAR(50) NOT NULL COMMENT '方法名称',\n")
        f.write("    nmi DECIMAL(5,4),\n")
        f.write("    hom DECIMAL(5,4),\n")
        f.write("    com DECIMAL(5,4),\n")
        f.write("    chaos DECIMAL(5,4),\n")
        f.write("    pas DECIMAL(5,4),\n")
        f.write("    asw DECIMAL(5,4),\n")
        f.write("    moran DECIMAL(5,4),\n")
        f.write("    geary DECIMAL(5,4),\n")
        f.write("    accuracy_score DECIMAL(5,4),\n")
        f.write("    FOREIGN KEY (sample_id) REFERENCES sample(sample_id) ON DELETE CASCADE,\n")
        f.write("    UNIQUE KEY uk_sample_method_perf (sample_id, method_name)\n")
        f.write(") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\n\n")
        
        # Spot表
        f.write("-- Spot表\n")
        f.write("CREATE TABLE IF NOT EXISTS spot (\n")
        f.write("    id BIGINT PRIMARY KEY AUTO_INCREMENT,\n")
        f.write("    sample_id VARCHAR(50) NOT NULL COMMENT '样本ID',\n")
        f.write("    spot_name VARCHAR(100) NOT NULL,\n")
        f.write("    x_coord INT,\n")
        f.write("    y_coord INT,\n")
        f.write("    consistency_score DECIMAL(5,4),\n")
        f.write("    complexity_level ENUM('High','Medium','Low') DEFAULT 'Low',\n")
        f.write("    FOREIGN KEY (sample_id) REFERENCES sample(sample_id) ON DELETE CASCADE,\n")
        f.write("    UNIQUE KEY uk_sample_spot (sample_id, spot_name)\n")
        f.write(") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\n\n")
        
        # 插入样本数据
        f.write("-- ============================================\n")
        f.write("-- 插入样本数据\n")
        f.write("-- ============================================\n\n")
        
        sample_ids = sorted(sample_info.keys())
        f.write("INSERT INTO sample (sample_id, technology, size, spots, genes, sparsity, annotation, type, dashboard_path) VALUES\n")
        
        for i, sample_id in enumerate(sample_ids):
            spots_count = sample_info[sample_id]
            
            if use_relative_path:
                # 使用相对路径
                dashboard_path = f"METHODS/{sample_id}_dashboard.html"
            else:
                # 使用绝对路径
                dashboard_path = os.path.join(current_dir, f"{sample_id}_dashboard.html")
                # 统一使用正斜杠
                dashboard_path = dashboard_path.replace("\\", "/")
            
            line = f"('{sample_id}', '10x visium', '55μm', {spots_count}, NULL, 0.96, '样本{sample_id}', 'home', '{dashboard_path}')"
            if i < len(sample_ids) - 1:
                line += ","
            else:
                line += ";"
            f.write(line + "\n")
        
        f.write("\n")
        
        # 插入方法数据
        f.write("-- ============================================\n")
        f.write("-- 插入方法数据\n")
        f.write("-- ============================================\n\n")
        
        for sample_id in sample_ids:
            f.write(f"-- 样本 {sample_id}\n")
            f.write("INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES\n")
            
            # 从结果文件中获取权重
            weight_dict = {}
            csv_file = f"{sample_id}_results.csv"
            if os.path.exists(csv_file):
                df = pd.read_csv(csv_file)
                for method in methods:
                    if f'weight_{method}' in df.columns:
                        weight = df[f'weight_{method}'].iloc[0]
                        weight_dict[method] = weight
                    else:
                        weight_dict[method] = 0
            else:
                for method in methods:
                    weight_dict[method] = 0
            
            # 生成 method 插入语句
            for i, method in enumerate(methods):
                weight = weight_dict[method]
                
                # 根据方法名确定路径
                if method == 'CCST':
                    original_filename = f"CCST_original_plots/{sample_id}_pred_label.png"
                elif method == 'conST':
                    original_filename = f"conST_original_plots/{sample_id}_pred_label.png"
                elif method == 'DeepST':
                    original_filename = f"DeepST_original_plots/{sample_id}_DeepST_domain.png"
                elif method == 'GraphST':
                    original_filename = f"GraphST_original_plots/{sample_id}_domain.png"
                elif method == 'spaceflow':
                    original_filename = f"spaceflow_original_plots/{sample_id}_domain.png"
                elif method == 'SpaGCN':
                    original_filename = f"SpaGCN_original_plots/{sample_id}_pred_label.png"
                elif method == 'STAGATE':
                    original_filename = f"STAGATE_original_plots/{sample_id}_pred_label.png"
                elif method == 'STAIG':
                    original_filename = f"STAIG_original_plots/{sample_id}_domain.png"
                else:
                    original_filename = f"{sample_id}_original_plots/{sample_id}_{method}.png"
                
                complex_filename = f"{sample_id}_plots_with_complex/{sample_id}_{method}_with_complex.png"
                
                if use_relative_path:
                    original_path = f"METHODS/{original_filename}"
                    complex_path = f"METHODS/{complex_filename}"
                else:
                    original_path = os.path.join(current_dir, original_filename).replace("\\", "/")
                    complex_path = os.path.join(current_dir, complex_filename).replace("\\", "/")
                
                line = f"('{sample_id}', '{method}', {weight}, '{original_path}', '{complex_path}')"
                if i < len(methods) - 1:
                    line += ","
                else:
                    line += ";"
                f.write(line + "\n")
            
            f.write("\n")
        
        # 插入性能数据
        f.write("-- ============================================\n")
        f.write("-- 插入性能数据\n")
        f.write("-- ============================================\n\n")
        
        for sample_id in sample_ids:
            f.write(f"-- 样本 {sample_id}\n")
            f.write("INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES\n")
            
            # 从 report.txt 文件中提取评估指标
            report_file = f"{sample_id}_report.txt"
            method_metrics = {}
            
            if os.path.exists(report_file):
                with open(report_file, 'r', encoding='utf-8') as f_report:
                    lines = f_report.readlines()
                    in_metrics_section = False
                    header_skipped = False
                    
                    for line in lines:
                        line = line.strip()
                        if '5. 评估指标 (每个方法)' in line:
                            in_metrics_section = True
                        elif in_metrics_section and line.startswith('---'):
                            continue
                        elif in_metrics_section and line and not line.startswith('6.'):
                            if not header_skipped and 'NMI' in line:
                                header_skipped = True
                                continue
                            
                            parts = line.split()
                            if len(parts) >= 10:
                                method_name = parts[0]
                                nmi = float(parts[1])
                                hom = float(parts[2])
                                com = float(parts[3])
                                chaos = float(parts[4])
                                pas = float(parts[5])
                                asw = float(parts[6])
                                moran = float(parts[7])
                                geary = float(parts[8])
                                accuracy_score = float(parts[9])
                                method_metrics[method_name] = {
                                    'nmi': nmi, 'hom': hom, 'com': com,
                                    'chaos': chaos, 'pas': pas, 'asw': asw,
                                    'moran': moran, 'geary': geary, 'accuracy_score': accuracy_score
                                }
            
            # 为每个方法生成 performance 数据
            for i, method in enumerate(methods):
                nmi = hom = com = chaos = pas = asw = moran = geary = accuracy_score = 0
                
                if method in method_metrics:
                    metrics = method_metrics[method]
                    nmi = metrics['nmi']
                    hom = metrics['hom']
                    com = metrics['com']
                    chaos = metrics['chaos']
                    pas = metrics['pas']
                    asw = metrics['asw']
                    moran = metrics['moran']
                    geary = metrics['geary']
                    accuracy_score = metrics['accuracy_score']
                
                line = f"('{sample_id}', '{method}', {nmi}, {hom}, {com}, {chaos}, {pas}, {asw}, {moran}, {geary}, {accuracy_score})"
                if i < len(methods) - 1:
                    line += ","
                else:
                    line += ";"
                f.write(line + "\n")
            
            f.write("\n")
        
        # 插入 spot 数据
        f.write("-- ============================================\n")
        f.write("-- 插入Spot数据\n")
        f.write("-- ============================================\n\n")
        
        for sample_id in sample_ids:
            f.write(f"-- 样本 {sample_id}\n")
            f.write("INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES\n")
            
            spots = spot_data[sample_id]
            if not spots.empty:
                for i, (_, row) in enumerate(spots.iterrows()):
                    spot_name = row['spot_name']
                    x_coord = int(row['x_coord'])
                    y_coord = int(row['y_coord'])
                    consistency_score = row['consistency_score']
                    complexity_level = row['complexity_level']
                    
                    if complexity_level == '高度复杂':
                        complexity_level = 'High'
                    elif complexity_level == '中等复杂':
                        complexity_level = 'Medium'
                    else:
                        complexity_level = 'Low'
                    
                    line = f"('{sample_id}', '{spot_name}', {x_coord}, {y_coord}, {consistency_score}, '{complexity_level}')"
                    if i < len(spots) - 1:
                        line += ","
                    else:
                        line += ";"
                    f.write(line + "\n")
            else:
                f.write(f"('{sample_id}', 'default', 0, 0, 0, 'Low');\n")
            
            f.write("\n")
    
    print(f"\nSQL file generated: {output_file}")
    print(f"  - Contains {len(sample_ids)} samples")
    print(f"  - Path mode: {'relative' if use_relative_path else 'absolute'}")
    print("\nUsage:")
    print(f"  mysql -uusername -p database < {output_file}")


def main():
    parser = argparse.ArgumentParser(description='生成数据库插入SQL脚本')
    parser.add_argument(
        '--relative', 
        action='store_true',
        help='使用相对路径（推荐，便于迁移）'
    )
    parser.add_argument(
        '--absolute',
        action='store_true',
        help='使用绝对路径'
    )
    
    args = parser.parse_args()
    
    # 默认使用相对路径
    use_relative = args.relative or not args.absolute
    
    print("="*50)
    print("  Spatial Transcriptomics SQL 生成器")
    print("="*50)
    
    generate_sql(use_relative_path=use_relative)


if __name__ == '__main__':
    main()
