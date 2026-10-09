-- 样本表
CREATE TABLE IF NOT EXISTS sample (
    sample_id VARCHAR(50) PRIMARY KEY COMMENT '样本ID (如 151508)',
    technology VARCHAR(50) NOT NULL,
    size VARCHAR(20),
    spots INT,
    genes INT,
    sparsity VARCHAR(10),
    annotation VARCHAR(255),
    type ENUM('home','nonTypical') DEFAULT 'home',
    dashboard_path VARCHAR(255) COMMENT 'dashboard.html文件名',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 方法表 (每个样本对应8种方法，每种方法有自己的权重和文件路径)
CREATE TABLE IF NOT EXISTS method (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    sample_id VARCHAR(50) NOT NULL COMMENT '样本ID',
    method_name VARCHAR(50) NOT NULL COMMENT '方法名称',
    weight DECIMAL(5,4) COMMENT '基于ground_truth的匹配率',
    file_path_original VARCHAR(255) COMMENT '原始聚类图路径',
    file_path_complex VARCHAR(255) COMMENT '带复杂标记的聚类图路径',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sample_id) REFERENCES sample(sample_id) ON DELETE CASCADE,
    UNIQUE KEY uk_sample_method (sample_id, method_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 性能指标表 (每个样本每个方法的性能)
CREATE TABLE IF NOT EXISTS performance (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    sample_id VARCHAR(50) NOT NULL COMMENT '样本ID',
    method_name VARCHAR(50) NOT NULL COMMENT '方法名称',
    nmi DECIMAL(5,4),
    hom DECIMAL(5,4),
    com DECIMAL(5,4),
    chaos DECIMAL(5,4),
    pas DECIMAL(5,4),
    asw DECIMAL(5,4),
    moran DECIMAL(5,4),
    geary DECIMAL(5,4),
    accuracy_score DECIMAL(5,4),
    FOREIGN KEY (sample_id) REFERENCES sample(sample_id) ON DELETE CASCADE,
    UNIQUE KEY uk_sample_method_perf (sample_id, method_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Spot表 (每个样本对应10个spot)
CREATE TABLE IF NOT EXISTS spot (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    sample_id VARCHAR(50) NOT NULL COMMENT '样本ID',
    spot_name VARCHAR(100) NOT NULL,
    x_coord INT,
    y_coord INT,
    consistency_score DECIMAL(5,4),
    complexity_level ENUM('High','Medium','Low') DEFAULT 'Low',
    FOREIGN KEY (sample_id) REFERENCES sample(sample_id) ON DELETE CASCADE,
    UNIQUE KEY uk_sample_spot (sample_id, spot_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 插入样本数据
INSERT INTO sample (sample_id, technology, size, spots, genes, sparsity, annotation, type, dashboard_path) VALUES
('151508', 'Visium', '6.5mm', 4381, 18000, '0.85', 'Human Brain (151508)', 'home', '151508_dashboard.html'),
('151512', 'Stereo-seq', '13mm', 9000, 20000, '0.78', 'Mouse Brain', 'nonTypical', NULL);

-- 插入方法数据（每个样本8种方法）
INSERT INTO method (sample_id, method_name, weight) VALUES
-- 样本151508的8种方法
('151508', 'STAIG', 0.7818),
('151508', 'STAGATE', 0.7131),
('151508', 'GraphST', 0.7124),
('151508', 'DeepST', 0.6649),
('151508', 'CCST', 0.6594),
('151508', 'SpaGCN', 0.5643),
('151508', 'conST', 0.4885),
('151508', 'spaceflow', 0.4839),
-- 样本151512的8种方法
('151512', 'STAIG', 0.7718),
('151512', 'STAGATE', 0.7031),
('151512', 'GraphST', 0.7024),
('151512', 'DeepST', 0.6549),
('151512', 'CCST', 0.6494),
('151512', 'SpaGCN', 0.5543),
('151512', 'conST', 0.4785),
('151512', 'spaceflow', 0.4739);

-- 插入性能数据（每个样本每个方法的性能）
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score)
VALUES
-- 样本151508的性能数据
('151508', 'STAIG', 0.78, 0.80, 0.76, 0.69, 0.86, 0.75, 0.82, 0.18, 0.85),
('151508', 'STAGATE', 0.71, 0.74, 0.70, 0.72, 0.82, 0.70, 0.78, 0.22, 0.79),
('151508', 'GraphST', 0.71, 0.73, 0.69, 0.73, 0.81, 0.69, 0.77, 0.23, 0.78),
('151508', 'DeepST', 0.66, 0.69, 0.65, 0.75, 0.77, 0.64, 0.72, 0.28, 0.72),
('151508', 'CCST', 0.65, 0.68, 0.64, 0.76, 0.76, 0.63, 0.71, 0.29, 0.71),
('151508', 'SpaGCN', 0.56, 0.59, 0.55, 0.80, 0.68, 0.54, 0.63, 0.37, 0.62),
('151508', 'conST', 0.48, 0.51, 0.47, 0.82, 0.62, 0.47, 0.56, 0.44, 0.55),
('151508', 'spaceflow', 0.48, 0.50, 0.46, 0.83, 0.61, 0.46, 0.55, 0.45, 0.54),
-- 样本151512的性能数据
('151512', 'STAIG', 0.77, 0.79, 0.75, 0.70, 0.85, 0.74, 0.81, 0.19, 0.84),
('151512', 'STAGATE', 0.70, 0.73, 0.69, 0.73, 0.81, 0.69, 0.77, 0.23, 0.78),
('151512', 'GraphST', 0.70, 0.72, 0.68, 0.74, 0.80, 0.68, 0.76, 0.24, 0.77),
('151512', 'DeepST', 0.65, 0.68, 0.64, 0.76, 0.76, 0.63, 0.71, 0.29, 0.71),
('151512', 'CCST', 0.64, 0.67, 0.63, 0.77, 0.75, 0.62, 0.70, 0.30, 0.70),
('151512', 'SpaGCN', 0.55, 0.58, 0.54, 0.81, 0.67, 0.53, 0.62, 0.38, 0.61),
('151512', 'conST', 0.47, 0.50, 0.46, 0.83, 0.61, 0.46, 0.55, 0.45, 0.54),
('151512', 'spaceflow', 0.47, 0.49, 0.45, 0.84, 0.60, 0.45, 0.54, 0.46, 0.53);

-- 插入Spot数据（每个样本10个spot）
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
-- 样本151508的10个spot
('151508', 'spot_1', 10, 20, 0.95, 'High'),
('151508', 'spot_2', 15, 25, 0.85, 'Medium'),
('151508', 'spot_3', 20, 30, 0.75, 'Medium'),
('151508', 'spot_4', 25, 35, 0.90, 'High'),
('151508', 'spot_5', 30, 40, 0.65, 'Low'),
('151508', 'spot_6', 35, 45, 0.80, 'Medium'),
('151508', 'spot_7', 40, 50, 0.92, 'High'),
('151508', 'spot_8', 45, 55, 0.70, 'Low'),
('151508', 'spot_9', 50, 60, 0.88, 'Medium'),
('151508', 'spot_10', 55, 65, 0.93, 'High'),
-- 样本151512的10个spot
('151512', 'spot_1', 10, 20, 0.94, 'High'),
('151512', 'spot_2', 15, 25, 0.84, 'Medium'),
('151512', 'spot_3', 20, 30, 0.74, 'Medium'),
('151512', 'spot_4', 25, 35, 0.89, 'High'),
('151512', 'spot_5', 30, 40, 0.64, 'Low'),
('151512', 'spot_6', 35, 45, 0.79, 'Medium'),
('151512', 'spot_7', 40, 50, 0.91, 'High'),
('151512', 'spot_8', 45, 55, 0.69, 'Low'),
('151512', 'spot_9', 50, 60, 0.87, 'Medium'),
('151512', 'spot_10', 55, 65, 0.92, 'High');