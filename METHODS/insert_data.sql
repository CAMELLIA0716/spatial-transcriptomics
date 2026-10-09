-- ============================================
-- Spatial Transcriptomics 数据库初始化脚本
-- ============================================
-- 生成时间: 2026-05-17 00:39:11.516004
-- 路径模式: 相对路径
-- ============================================

-- ============================================
-- 创建数据表
-- ============================================

-- 样本表
CREATE TABLE IF NOT EXISTS sample (
    sample_id VARCHAR(50) PRIMARY KEY COMMENT '样本ID',
    technology VARCHAR(50) NOT NULL,
    size VARCHAR(20),
    spots INT,
    genes INT,
    sparsity VARCHAR(10),
    annotation VARCHAR(255),
    type ENUM('home','nonTypical') DEFAULT 'home',
    dashboard_path VARCHAR(255) COMMENT 'dashboard路径',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 方法表
CREATE TABLE IF NOT EXISTS method (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    sample_id VARCHAR(50) NOT NULL COMMENT '样本ID',
    method_name VARCHAR(50) NOT NULL COMMENT '方法名称',
    weight DECIMAL(5,4) COMMENT '权重',
    file_path_original VARCHAR(255) COMMENT '原始聚类图路径',
    file_path_complex VARCHAR(255) COMMENT '复杂标记图路径',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sample_id) REFERENCES sample(sample_id) ON DELETE CASCADE,
    UNIQUE KEY uk_sample_method (sample_id, method_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 性能指标表
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

-- Spot表
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

-- ============================================
-- 插入样本数据
-- ============================================

INSERT INTO sample (sample_id, technology, size, spots, genes, sparsity, annotation, type, dashboard_path) VALUES
('151507', '10x visium', '55μm', 4221, NULL, 0.96, '样本151507', 'home', 'METHODS/151507_dashboard.html'),
('151508', '10x visium', '55μm', 4381, NULL, 0.96, '样本151508', 'home', 'METHODS/151508_dashboard.html'),
('151509', '10x visium', '55μm', 4788, NULL, 0.96, '样本151509', 'home', 'METHODS/151509_dashboard.html'),
('151510', '10x visium', '55μm', 4595, NULL, 0.96, '样本151510', 'home', 'METHODS/151510_dashboard.html'),
('151669', '10x visium', '55μm', 3636, NULL, 0.96, '样本151669', 'home', 'METHODS/151669_dashboard.html'),
('151670', '10x visium', '55μm', 3484, NULL, 0.96, '样本151670', 'home', 'METHODS/151670_dashboard.html'),
('151671', '10x visium', '55μm', 4093, NULL, 0.96, '样本151671', 'home', 'METHODS/151671_dashboard.html'),
('151672', '10x visium', '55μm', 3888, NULL, 0.96, '样本151672', 'home', 'METHODS/151672_dashboard.html'),
('151673', '10x visium', '55μm', 3611, NULL, 0.96, '样本151673', 'home', 'METHODS/151673_dashboard.html'),
('151674', '10x visium', '55μm', 3635, NULL, 0.96, '样本151674', 'home', 'METHODS/151674_dashboard.html'),
('151675', '10x visium', '55μm', 3566, NULL, 0.96, '样本151675', 'home', 'METHODS/151675_dashboard.html'),
('151676', '10x visium', '55μm', 3431, NULL, 0.96, '样本151676', 'home', 'METHODS/151676_dashboard.html');

-- ============================================
-- 插入方法数据
-- ============================================

-- 样本 151507
INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES
('151507', 'CCST', 0.460561870768003, 'METHODS/CCST_original_plots/151507_pred_label.png', 'METHODS/151507_plots_with_complex/151507_CCST_with_complex.png'),
('151507', 'conST', 0.4216105681992422, 'METHODS/conST_original_plots/151507_pred_label.png', 'METHODS/151507_plots_with_complex/151507_conST_with_complex.png'),
('151507', 'DeepST', 0.4555435949003135, 'METHODS/DeepST_original_plots/151507_DeepST_domain.png', 'METHODS/151507_plots_with_complex/151507_DeepST_with_complex.png'),
('151507', 'GraphST', 0.4729593913485874, 'METHODS/GraphST_original_plots/151507_domain.png', 'METHODS/151507_plots_with_complex/151507_GraphST_with_complex.png'),
('151507', 'spaceflow', 0.4507583943386201, 'METHODS/spaceflow_original_plots/151507_domain.png', 'METHODS/151507_plots_with_complex/151507_spaceflow_with_complex.png'),
('151507', 'SpaGCN', 0.4650528327687373, 'METHODS/SpaGCN_original_plots/151507_pred_label.png', 'METHODS/151507_plots_with_complex/151507_SpaGCN_with_complex.png'),
('151507', 'STAGATE', 0.4636570511834405, 'METHODS/STAGATE_original_plots/151507_pred_label.png', 'METHODS/151507_plots_with_complex/151507_STAGATE_with_complex.png'),
('151507', 'STAIG', 0.3653260898797152, 'METHODS/STAIG_original_plots/151507_domain.png', 'METHODS/151507_plots_with_complex/151507_STAIG_with_complex.png');

-- 样本 151508
INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES
('151508', 'CCST', 0.3613269462033636, 'METHODS/CCST_original_plots/151508_pred_label.png', 'METHODS/151508_plots_with_complex/151508_CCST_with_complex.png'),
('151508', 'conST', 0.3838361226235087, 'METHODS/conST_original_plots/151508_pred_label.png', 'METHODS/151508_plots_with_complex/151508_conST_with_complex.png'),
('151508', 'DeepST', 0.5061367197377237, 'METHODS/DeepST_original_plots/151508_DeepST_domain.png', 'METHODS/151508_plots_with_complex/151508_DeepST_with_complex.png'),
('151508', 'GraphST', 0.4672611961917488, 'METHODS/GraphST_original_plots/151508_domain.png', 'METHODS/151508_plots_with_complex/151508_GraphST_with_complex.png'),
('151508', 'spaceflow', 0.3895455137757325, 'METHODS/spaceflow_original_plots/151508_domain.png', 'METHODS/151508_plots_with_complex/151508_spaceflow_with_complex.png'),
('151508', 'SpaGCN', 0.445719888269194, 'METHODS/SpaGCN_original_plots/151508_pred_label.png', 'METHODS/151508_plots_with_complex/151508_SpaGCN_with_complex.png'),
('151508', 'STAGATE', 0.4809132002234518, 'METHODS/STAGATE_original_plots/151508_pred_label.png', 'METHODS/151508_plots_with_complex/151508_STAGATE_with_complex.png'),
('151508', 'STAIG', 0.4271223999161314, 'METHODS/STAIG_original_plots/151508_domain.png', 'METHODS/151508_plots_with_complex/151508_STAIG_with_complex.png');

-- 样本 151509
INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES
('151509', 'CCST', 0.4475028263045046, 'METHODS/CCST_original_plots/151509_pred_label.png', 'METHODS/151509_plots_with_complex/151509_CCST_with_complex.png'),
('151509', 'conST', 0.330805943858116, 'METHODS/conST_original_plots/151509_pred_label.png', 'METHODS/151509_plots_with_complex/151509_conST_with_complex.png'),
('151509', 'DeepST', 0.4359222800923648, 'METHODS/DeepST_original_plots/151509_DeepST_domain.png', 'METHODS/151509_plots_with_complex/151509_DeepST_with_complex.png'),
('151509', 'GraphST', 0.447184650809625, 'METHODS/GraphST_original_plots/151509_domain.png', 'METHODS/151509_plots_with_complex/151509_GraphST_with_complex.png'),
('151509', 'spaceflow', 0.4253413150631709, 'METHODS/spaceflow_original_plots/151509_domain.png', 'METHODS/151509_plots_with_complex/151509_spaceflow_with_complex.png'),
('151509', 'SpaGCN', 0.4709802533861827, 'METHODS/SpaGCN_original_plots/151509_pred_label.png', 'METHODS/151509_plots_with_complex/151509_SpaGCN_with_complex.png'),
('151509', 'STAGATE', 0.4783521676248797, 'METHODS/STAGATE_original_plots/151509_pred_label.png', 'METHODS/151509_plots_with_complex/151509_STAGATE_with_complex.png'),
('151509', 'STAIG', 0.4001623094541889, 'METHODS/STAIG_original_plots/151509_domain.png', 'METHODS/151509_plots_with_complex/151509_STAIG_with_complex.png');

-- 样本 151510
INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES
('151510', 'CCST', 0.3586123703086096, 'METHODS/CCST_original_plots/151510_pred_label.png', 'METHODS/151510_plots_with_complex/151510_CCST_with_complex.png'),
('151510', 'conST', 0.4319928101490997, 'METHODS/conST_original_plots/151510_pred_label.png', 'METHODS/151510_plots_with_complex/151510_conST_with_complex.png'),
('151510', 'DeepST', 0.4391933481609634, 'METHODS/DeepST_original_plots/151510_DeepST_domain.png', 'METHODS/151510_plots_with_complex/151510_DeepST_with_complex.png'),
('151510', 'GraphST', 0.4642998466029286, 'METHODS/GraphST_original_plots/151510_domain.png', 'METHODS/151510_plots_with_complex/151510_GraphST_with_complex.png'),
('151510', 'spaceflow', 0.4613315783798883, 'METHODS/spaceflow_original_plots/151510_domain.png', 'METHODS/151510_plots_with_complex/151510_spaceflow_with_complex.png'),
('151510', 'SpaGCN', 0.5026892205999677, 'METHODS/SpaGCN_original_plots/151510_pred_label.png', 'METHODS/151510_plots_with_complex/151510_SpaGCN_with_complex.png'),
('151510', 'STAGATE', 0.5021836353720064, 'METHODS/STAGATE_original_plots/151510_pred_label.png', 'METHODS/151510_plots_with_complex/151510_STAGATE_with_complex.png'),
('151510', 'STAIG', 0.4942832995994758, 'METHODS/STAIG_original_plots/151510_domain.png', 'METHODS/151510_plots_with_complex/151510_STAIG_with_complex.png');

-- 样本 151669
INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES
('151669', 'CCST', 0.4171291098654175, 'METHODS/CCST_original_plots/151669_pred_label.png', 'METHODS/151669_plots_with_complex/151669_CCST_with_complex.png'),
('151669', 'conST', 0.3552162778677685, 'METHODS/conST_original_plots/151669_pred_label.png', 'METHODS/151669_plots_with_complex/151669_conST_with_complex.png'),
('151669', 'DeepST', 0.4256936084036615, 'METHODS/DeepST_original_plots/151669_DeepST_domain.png', 'METHODS/151669_plots_with_complex/151669_DeepST_with_complex.png'),
('151669', 'GraphST', 0.4771327373176979, 'METHODS/GraphST_original_plots/151669_domain.png', 'METHODS/151669_plots_with_complex/151669_GraphST_with_complex.png'),
('151669', 'spaceflow', 0.4441353312111609, 'METHODS/spaceflow_original_plots/151669_domain.png', 'METHODS/151669_plots_with_complex/151669_spaceflow_with_complex.png'),
('151669', 'SpaGCN', 0.3878070884716134, 'METHODS/SpaGCN_original_plots/151669_pred_label.png', 'METHODS/151669_plots_with_complex/151669_SpaGCN_with_complex.png'),
('151669', 'STAGATE', 0.3746008502842499, 'METHODS/STAGATE_original_plots/151669_pred_label.png', 'METHODS/151669_plots_with_complex/151669_STAGATE_with_complex.png'),
('151669', 'STAIG', 0.4581495990221876, 'METHODS/STAIG_original_plots/151669_domain.png', 'METHODS/151669_plots_with_complex/151669_STAIG_with_complex.png');

-- 样本 151670
INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES
('151670', 'CCST', 0.4445607392091679, 'METHODS/CCST_original_plots/151670_pred_label.png', 'METHODS/151670_plots_with_complex/151670_CCST_with_complex.png'),
('151670', 'conST', 0.4462130496993985, 'METHODS/conST_original_plots/151670_pred_label.png', 'METHODS/151670_plots_with_complex/151670_conST_with_complex.png'),
('151670', 'DeepST', 0.5583607668760043, 'METHODS/DeepST_original_plots/151670_DeepST_domain.png', 'METHODS/151670_plots_with_complex/151670_DeepST_with_complex.png'),
('151670', 'GraphST', 0.5919462982619936, 'METHODS/GraphST_original_plots/151670_domain.png', 'METHODS/151670_plots_with_complex/151670_GraphST_with_complex.png'),
('151670', 'spaceflow', 0.5200886844661587, 'METHODS/spaceflow_original_plots/151670_domain.png', 'METHODS/151670_plots_with_complex/151670_spaceflow_with_complex.png'),
('151670', 'SpaGCN', 0.5217962069760519, 'METHODS/SpaGCN_original_plots/151670_pred_label.png', 'METHODS/151670_plots_with_complex/151670_SpaGCN_with_complex.png'),
('151670', 'STAGATE', 0.5940435565037361, 'METHODS/STAGATE_original_plots/151670_pred_label.png', 'METHODS/151670_plots_with_complex/151670_STAGATE_with_complex.png'),
('151670', 'STAIG', 0.4943622838260567, 'METHODS/STAIG_original_plots/151670_domain.png', 'METHODS/151670_plots_with_complex/151670_STAIG_with_complex.png');

-- 样本 151671
INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES
('151671', 'CCST', 0.3518140059337181, 'METHODS/CCST_original_plots/151671_pred_label.png', 'METHODS/151671_plots_with_complex/151671_CCST_with_complex.png'),
('151671', 'conST', 0.4352978897901137, 'METHODS/conST_original_plots/151671_pred_label.png', 'METHODS/151671_plots_with_complex/151671_conST_with_complex.png'),
('151671', 'DeepST', 0.5980988983234133, 'METHODS/DeepST_original_plots/151671_DeepST_domain.png', 'METHODS/151671_plots_with_complex/151671_DeepST_with_complex.png'),
('151671', 'GraphST', 0.6138810797072892, 'METHODS/GraphST_original_plots/151671_domain.png', 'METHODS/151671_plots_with_complex/151671_GraphST_with_complex.png'),
('151671', 'spaceflow', 0.5580474741806006, 'METHODS/spaceflow_original_plots/151671_domain.png', 'METHODS/151671_plots_with_complex/151671_spaceflow_with_complex.png'),
('151671', 'SpaGCN', 0.6000036506331504, 'METHODS/SpaGCN_original_plots/151671_pred_label.png', 'METHODS/151671_plots_with_complex/151671_SpaGCN_with_complex.png'),
('151671', 'STAGATE', 0.6059668448868724, 'METHODS/STAGATE_original_plots/151671_pred_label.png', 'METHODS/151671_plots_with_complex/151671_STAGATE_with_complex.png'),
('151671', 'STAIG', 0.532663604408535, 'METHODS/STAIG_original_plots/151671_domain.png', 'METHODS/151671_plots_with_complex/151671_STAIG_with_complex.png');

-- 样本 151672
INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES
('151672', 'CCST', 0.5241334226126564, 'METHODS/CCST_original_plots/151672_pred_label.png', 'METHODS/151672_plots_with_complex/151672_CCST_with_complex.png'),
('151672', 'conST', 0.606536786889556, 'METHODS/conST_original_plots/151672_pred_label.png', 'METHODS/151672_plots_with_complex/151672_conST_with_complex.png'),
('151672', 'DeepST', 0.6216230429558361, 'METHODS/DeepST_original_plots/151672_DeepST_domain.png', 'METHODS/151672_plots_with_complex/151672_DeepST_with_complex.png'),
('151672', 'GraphST', 0.6158989879181995, 'METHODS/GraphST_original_plots/151672_domain.png', 'METHODS/151672_plots_with_complex/151672_GraphST_with_complex.png'),
('151672', 'spaceflow', 0.5587605248896291, 'METHODS/spaceflow_original_plots/151672_domain.png', 'METHODS/151672_plots_with_complex/151672_spaceflow_with_complex.png'),
('151672', 'SpaGCN', 0.5922467197151946, 'METHODS/SpaGCN_original_plots/151672_pred_label.png', 'METHODS/151672_plots_with_complex/151672_SpaGCN_with_complex.png'),
('151672', 'STAGATE', 0.5281727883842241, 'METHODS/STAGATE_original_plots/151672_pred_label.png', 'METHODS/151672_plots_with_complex/151672_STAGATE_with_complex.png'),
('151672', 'STAIG', 0.4077195994761298, 'METHODS/STAIG_original_plots/151672_domain.png', 'METHODS/151672_plots_with_complex/151672_STAIG_with_complex.png');

-- 样本 151673
INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES
('151673', 'CCST', 0.3484682291265126, 'METHODS/CCST_original_plots/151673_pred_label.png', 'METHODS/151673_plots_with_complex/151673_CCST_with_complex.png'),
('151673', 'conST', 0.4263441841310385, 'METHODS/conST_original_plots/151673_pred_label.png', 'METHODS/151673_plots_with_complex/151673_conST_with_complex.png'),
('151673', 'DeepST', 0.395307560755307, 'METHODS/DeepST_original_plots/151673_DeepST_domain.png', 'METHODS/151673_plots_with_complex/151673_DeepST_with_complex.png'),
('151673', 'GraphST', 0.39761280282765, 'METHODS/GraphST_original_plots/151673_domain.png', 'METHODS/151673_plots_with_complex/151673_GraphST_with_complex.png'),
('151673', 'spaceflow', 0.3868869682395954, 'METHODS/spaceflow_original_plots/151673_domain.png', 'METHODS/151673_plots_with_complex/151673_spaceflow_with_complex.png'),
('151673', 'SpaGCN', 0.3793823194627363, 'METHODS/SpaGCN_original_plots/151673_pred_label.png', 'METHODS/151673_plots_with_complex/151673_SpaGCN_with_complex.png'),
('151673', 'STAGATE', 0.410993634402216, 'METHODS/STAGATE_original_plots/151673_pred_label.png', 'METHODS/151673_plots_with_complex/151673_STAGATE_with_complex.png'),
('151673', 'STAIG', 0.4268371637038308, 'METHODS/STAIG_original_plots/151673_domain.png', 'METHODS/151673_plots_with_complex/151673_STAIG_with_complex.png');

-- 样本 151674
INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES
('151674', 'CCST', 0.4874997915244646, 'METHODS/CCST_original_plots/151674_pred_label.png', 'METHODS/151674_plots_with_complex/151674_CCST_with_complex.png'),
('151674', 'conST', 0.4525166359634401, 'METHODS/conST_original_plots/151674_pred_label.png', 'METHODS/151674_plots_with_complex/151674_conST_with_complex.png'),
('151674', 'DeepST', 0.4890031057282621, 'METHODS/DeepST_original_plots/151674_DeepST_domain.png', 'METHODS/151674_plots_with_complex/151674_DeepST_with_complex.png'),
('151674', 'GraphST', 0.4896727406766475, 'METHODS/GraphST_original_plots/151674_domain.png', 'METHODS/151674_plots_with_complex/151674_GraphST_with_complex.png'),
('151674', 'spaceflow', 0.3913287729774305, 'METHODS/spaceflow_original_plots/151674_domain.png', 'METHODS/151674_plots_with_complex/151674_spaceflow_with_complex.png'),
('151674', 'SpaGCN', 0.4355502218269364, 'METHODS/SpaGCN_original_plots/151674_pred_label.png', 'METHODS/151674_plots_with_complex/151674_SpaGCN_with_complex.png'),
('151674', 'STAGATE', 0.4970345722506009, 'METHODS/STAGATE_original_plots/151674_pred_label.png', 'METHODS/151674_plots_with_complex/151674_STAGATE_with_complex.png'),
('151674', 'STAIG', 0.4743867917893917, 'METHODS/STAIG_original_plots/151674_domain.png', 'METHODS/151674_plots_with_complex/151674_STAIG_with_complex.png');

-- 样本 151675
INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES
('151675', 'CCST', 0.4010645430176675, 'METHODS/CCST_original_plots/151675_pred_label.png', 'METHODS/151675_plots_with_complex/151675_CCST_with_complex.png'),
('151675', 'conST', 0.3970176422548238, 'METHODS/conST_original_plots/151675_pred_label.png', 'METHODS/151675_plots_with_complex/151675_conST_with_complex.png'),
('151675', 'DeepST', 0.4887526387477386, 'METHODS/DeepST_original_plots/151675_DeepST_domain.png', 'METHODS/151675_plots_with_complex/151675_DeepST_with_complex.png'),
('151675', 'GraphST', 0.5240706899047956, 'METHODS/GraphST_original_plots/151675_domain.png', 'METHODS/151675_plots_with_complex/151675_GraphST_with_complex.png'),
('151675', 'spaceflow', 0.3753772934860988, 'METHODS/spaceflow_original_plots/151675_domain.png', 'METHODS/151675_plots_with_complex/151675_spaceflow_with_complex.png'),
('151675', 'SpaGCN', 0.5106560174974734, 'METHODS/SpaGCN_original_plots/151675_pred_label.png', 'METHODS/151675_plots_with_complex/151675_SpaGCN_with_complex.png'),
('151675', 'STAGATE', 0.4290270319657809, 'METHODS/STAGATE_original_plots/151675_pred_label.png', 'METHODS/151675_plots_with_complex/151675_STAGATE_with_complex.png'),
('151675', 'STAIG', 0.433087991993444, 'METHODS/STAIG_original_plots/151675_domain.png', 'METHODS/151675_plots_with_complex/151675_STAIG_with_complex.png');

-- 样本 151676
INSERT INTO method (sample_id, method_name, weight, file_path_original, file_path_complex) VALUES
('151676', 'CCST', 0.394141915757902, 'METHODS/CCST_original_plots/151676_pred_label.png', 'METHODS/151676_plots_with_complex/151676_CCST_with_complex.png'),
('151676', 'conST', 0.4262311673230681, 'METHODS/conST_original_plots/151676_pred_label.png', 'METHODS/151676_plots_with_complex/151676_conST_with_complex.png'),
('151676', 'DeepST', 0.4226837324926432, 'METHODS/DeepST_original_plots/151676_DeepST_domain.png', 'METHODS/151676_plots_with_complex/151676_DeepST_with_complex.png'),
('151676', 'GraphST', 0.5153767001810395, 'METHODS/GraphST_original_plots/151676_domain.png', 'METHODS/151676_plots_with_complex/151676_GraphST_with_complex.png'),
('151676', 'spaceflow', 0.3913824696148799, 'METHODS/spaceflow_original_plots/151676_domain.png', 'METHODS/151676_plots_with_complex/151676_spaceflow_with_complex.png'),
('151676', 'SpaGCN', 0.4160724824400791, 'METHODS/SpaGCN_original_plots/151676_pred_label.png', 'METHODS/151676_plots_with_complex/151676_SpaGCN_with_complex.png'),
('151676', 'STAGATE', 0.4751433380101984, 'METHODS/STAGATE_original_plots/151676_pred_label.png', 'METHODS/151676_plots_with_complex/151676_STAGATE_with_complex.png'),
('151676', 'STAIG', 0.4935339350820322, 'METHODS/STAIG_original_plots/151676_domain.png', 'METHODS/151676_plots_with_complex/151676_STAIG_with_complex.png');

-- ============================================
-- 插入性能数据
-- ============================================

-- 样本 151507
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES
('151507', 'CCST', 0.6773, 0.6458, 0.712, 0.0563, 0.0106, 0.4802, 0.8888, 0.1118, 0.5359),
('151507', 'conST', 0.5431, 0.5692, 0.5591, 0.0578, 0.0742, 0.4898, 0.8047, 0.1954, 0.6077),
('151507', 'DeepST', 0.5963, 0.6417, 0.622, 0.0565, 0.0419, 0.5131, 0.8837, 0.1166, 0.6141),
('151507', 'GraphST', 0.6449, 0.6202, 0.6716, 0.0564, 0.0104, 0.5063, 0.8976, 0.1025, 0.421),
('151507', 'spaceflow', 0.5363, 0.5371, 0.5355, 0.0565, 0.0253, 0.5338, 0.9365, 0.0636, 0.3726),
('151507', 'SpaGCN', 0.5483, 0.5584, 0.5481, 0.0633, 0.244, 0.4923, 0.8046, 0.1957, 0.6065),
('151507', 'STAGATE', 0.6932, 0.6833, 0.7033, 0.0564, 0.0332, 0.5083, 0.9163, 0.0828, 0.5372),
('151507', 'STAIG', 0.6113, 0.612, 0.612, 0.0807, 0.0069, 0.0397, 0.9419, 0.0579, 1.0);

-- 样本 151508
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES
('151508', 'CCST', 0.5478, 0.5247, 0.573, 0.0551, 0.0091, 0.4985, 0.8499, 0.1493, 0.3238),
('151508', 'conST', 0.3752, 0.3572, 0.3298, 0.0644, 0.3223, 0.4601, 0.6413, 0.3583, 0.4469),
('151508', 'DeepST', 0.5825, 0.6196, 0.5923, 0.0567, 0.0415, 0.5431, 0.882, 0.1175, 0.6437),
('151508', 'GraphST', 0.6441, 0.6428, 0.6453, 0.0551, 0.0148, 0.5138, 0.9152, 0.0849, 0.4906),
('151508', 'spaceflow', 0.4427, 0.4562, 0.43, 0.0555, 0.0301, 0.5242, 0.9004, 0.0996, 0.2785),
('151508', 'SpaGCN', 0.5089, 0.4818, 0.4704, 0.0611, 0.2527, 0.4736, 0.6813, 0.3186, 0.5859),
('151508', 'STAGATE', 0.6689, 0.6927, 0.6466, 0.0554, 0.0415, 0.5245, 0.8271, 0.1724, 0.5267),
('151508', 'STAIG', 0.5563, 0.5569, 0.5569, 0.0812, 0.0157, 0.0394, 0.9148, 0.0852, 1.0);

-- 样本 151509
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES
('151509', 'CCST', 0.6295, 0.6422, 0.6173, 0.0535, 0.0106, 0.4773, 0.8253, 0.1746, 0.4222),
('151509', 'conST', 0.3791, 0.4223, 0.3645, 0.0571, 0.2872, 0.4589, 0.6064, 0.394, 0.3822),
('151509', 'DeepST', 0.5584, 0.6302, 0.5614, 0.054, 0.0351, 0.5025, 0.9166, 0.0832, 0.5718),
('151509', 'GraphST', 0.6581, 0.6823, 0.6356, 0.0537, 0.0148, 0.4686, 0.9167, 0.0833, 0.4849),
('151509', 'spaceflow', 0.4414, 0.4777, 0.4102, 0.0535, 0.0286, 0.5169, 0.877, 0.1239, 0.2254),
('151509', 'SpaGCN', 0.5323, 0.586, 0.5381, 0.0584, 0.2704, 0.4743, 0.7804, 0.2198, 0.603),
('151509', 'STAGATE', 0.704, 0.7317, 0.6784, 0.0536, 0.0347, 0.4808, 0.9261, 0.0735, 0.5766),
('151509', 'STAIG', 0.5699, 0.5702, 0.5702, 0.0895, 0.009, -0.0654, 0.8459, 0.1536, 1.0);

-- 样本 151510
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES
('151510', 'CCST', 0.6046, 0.5999, 0.6094, 0.0547, 0.0071, 0.4628, 0.9171, 0.0827, 0.3863),
('151510', 'conST', 0.5114, 0.529, 0.46, 0.0576, 0.1423, 0.4548, 0.621, 0.3781, 0.5058),
('151510', 'DeepST', 0.5063, 0.5068, 0.46, 0.0556, 0.0457, 0.523, 0.8873, 0.1132, 0.5375),
('151510', 'GraphST', 0.6436, 0.6435, 0.6438, 0.0555, 0.0172, 0.4428, 0.9562, 0.0438, 0.5041),
('151510', 'spaceflow', 0.4836, 0.525, 0.4482, 0.0556, 0.0344, 0.5031, 0.9235, 0.0761, 0.3206),
('151510', 'SpaGCN', 0.5543, 0.608, 0.5575, 0.0594, 0.262, 0.477, 0.8074, 0.1928, 0.7106),
('151510', 'STAGATE', 0.6473, 0.6733, 0.6232, 0.0555, 0.0411, 0.4503, 0.9107, 0.0897, 0.5351),
('151510', 'STAIG', 0.5793, 0.5802, 0.5802, 0.088, 0.015, -0.1032, 0.9043, 0.0959, 1.0);

-- 样本 151669
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES
('151669', 'CCST', 0.571, 0.601, 0.5439, 0.0608, 0.0087, 0.5144, 0.9407, 0.0592, 0.3865),
('151669', 'conST', 0.4744, 0.6256, 0.5269, 0.0614, 0.0426, 0.5335, 0.8778, 0.1224, 0.5495),
('151669', 'DeepST', 0.5235, 0.6466, 0.4999, 0.0617, 0.0298, 0.5663, 0.8826, 0.1175, 0.5718),
('151669', 'GraphST', 0.5877, 0.6161, 0.5618, 0.0612, 0.0094, 0.5645, 0.9317, 0.0684, 0.4736),
('151669', 'spaceflow', 0.4801, 0.5449, 0.4291, 0.0612, 0.005, 0.6036, 0.9243, 0.0759, 0.357),
('151669', 'SpaGCN', 0.4037, 0.4733, 0.3724, 0.0672, 0.2611, 0.502, 0.7946, 0.2056, 0.5561),
('151669', 'STAGATE', 0.5061, 0.5525, 0.4668, 0.0616, 0.0294, 0.5717, 0.8504, 0.1497, 0.2743),
('151669', 'STAIG', 0.5478, 0.5563, 0.5563, 0.0391, 0.003, 0.0241, 0.9379, 0.0625, 1.0);

-- 样本 151670
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES
('151670', 'CCST', 0.611, 0.5689, 0.6598, 0.0602, 0.006, 0.5088, 0.9593, 0.0406, 0.6404),
('151670', 'conST', 0.4927, 0.5782, 0.4289, 0.0607, 0.0373, 0.529, 0.857, 0.1433, 0.3774),
('151670', 'DeepST', 0.5523, 0.6515, 0.4987, 0.061, 0.0352, 0.5636, 0.8651, 0.1346, 0.5445),
('151670', 'GraphST', 0.5748, 0.6611, 0.5085, 0.0603, 0.0115, 0.5603, 0.957, 0.0435, 0.4121),
('151670', 'spaceflow', 0.4556, 0.5451, 0.3913, 0.0603, 0.0086, 0.5696, 0.9346, 0.0651, 0.2855),
('151670', 'SpaGCN', 0.5263, 0.5279, 0.4247, 0.0669, 0.1209, 0.5507, 0.8138, 0.1852, 0.558),
('151670', 'STAGATE', 0.5746, 0.6463, 0.5171, 0.0615, 0.023, 0.5472, 0.9058, 0.0941, 0.488),
('151670', 'STAIG', 0.5362, 0.546, 0.546, 0.0436, 0.0063, -0.0001, 0.8631, 0.1359, 1.0);

-- 样本 151671
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES
('151671', 'CCST', 0.6076, 0.6014, 0.6139, 0.0577, 0.0066, 0.5402, 0.9627, 0.0372, 0.4751),
('151671', 'conST', 0.5931, 0.6766, 0.6429, 0.058, 0.0305, 0.5466, 0.877, 0.1232, 0.6758),
('151671', 'DeepST', 0.6276, 0.6766, 0.5954, 0.0577, 0.0358, 0.5675, 0.9202, 0.08, 0.6142),
('151671', 'GraphST', 0.7356, 0.7712, 0.7032, 0.0577, 0.0086, 0.5692, 0.9706, 0.0295, 0.6386),
('151671', 'spaceflow', 0.6085, 0.6422, 0.5782, 0.0577, 0.01, 0.5714, 0.941, 0.0589, 0.4685),
('151671', 'SpaGCN', 0.6043, 0.6724, 0.5953, 0.0628, 0.1438, 0.5255, 0.8313, 0.1683, 0.6807),
('151671', 'STAGATE', 0.7039, 0.7327, 0.6773, 0.0578, 0.0237, 0.5518, 0.9476, 0.0527, 0.5818),
('151671', 'STAIG', 0.6586, 0.6598, 0.6598, 0.0508, 0.0061, 0.0699, 0.935, 0.0651, 1.0);

-- 样本 151672
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES
('151672', 'CCST', 0.5997, 0.5911, 0.6086, 0.0582, 0.0087, 0.5347, 0.9112, 0.089, 0.4324),
('151672', 'conST', 0.6629, 0.6622, 0.6056, 0.0603, 0.0476, 0.5668, 0.95, 0.0493, 0.7253),
('151672', 'DeepST', 0.6677, 0.6731, 0.6141, 0.0583, 0.0438, 0.5533, 0.9399, 0.0605, 0.6965),
('151672', 'GraphST', 0.7159, 0.73, 0.7023, 0.0595, 0.0064, 0.556, 0.9303, 0.0697, 0.6354),
('151672', 'spaceflow', 0.5653, 0.5872, 0.545, 0.0595, 0.0093, 0.5887, 0.9491, 0.0513, 0.4447),
('151672', 'SpaGCN', 0.5859, 0.5983, 0.5506, 0.0611, 0.0962, 0.5445, 0.7783, 0.2219, 0.671),
('151672', 'STAGATE', 0.6169, 0.5983, 0.6366, 0.0596, 0.0219, 0.5334, 0.8561, 0.1443, 0.469),
('151672', 'STAIG', 0.6656, 0.6667, 0.6667, 0.0513, 0.0051, 0.0907, 0.8883, 0.1119, 1.0);

-- 样本 151673
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES
('151673', 'CCST', 0.5873, 0.5463, 0.6348, 0.0603, 0.011, 0.4812, 0.8979, 0.1021, 0.3558),
('151673', 'conST', 0.6385, 0.6994, 0.6577, 0.0605, 0.0313, 0.5114, 0.8735, 0.1261, 0.6519),
('151673', 'DeepST', 0.6061, 0.5821, 0.6614, 0.0607, 0.0382, 0.4964, 0.9101, 0.0878, 0.6164),
('151673', 'GraphST', 0.7453, 0.7347, 0.7562, 0.0605, 0.0144, 0.5013, 0.8699, 0.1305, 0.6511),
('151673', 'spaceflow', 0.4637, 0.4723, 0.4555, 0.0611, 0.0584, 0.5325, 0.8501, 0.1495, 0.3545),
('151673', 'SpaGCN', 0.6116, 0.637, 0.6027, 0.0649, 0.2036, 0.4843, 0.8409, 0.1605, 0.6084),
('151673', 'STAGATE', 0.6995, 0.7117, 0.6878, 0.0606, 0.0255, 0.5145, 0.8826, 0.1164, 0.5596),
('151673', 'STAIG', 0.6482, 0.6495, 0.6495, 0.0924, 0.0058, 0.0445, 0.8327, 0.1666, 1.0);

-- 样本 151674
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES
('151674', 'CCST', 0.6463, 0.621, 0.6738, 0.0601, 0.0136, 0.5186, 0.8881, 0.1116, 0.5299),
('151674', 'conST', 0.5544, 0.6357, 0.6159, 0.0598, 0.0286, 0.5226, 0.8735, 0.1265, 0.5953),
('151674', 'DeepST', 0.5481, 0.5872, 0.6059, 0.0599, 0.0316, 0.5511, 0.8939, 0.1061, 0.6391),
('151674', 'GraphST', 0.6756, 0.6654, 0.6861, 0.0598, 0.0162, 0.5196, 0.9192, 0.0803, 0.5904),
('151674', 'spaceflow', 0.3656, 0.3694, 0.3619, 0.0604, 0.0481, 0.501, 0.8775, 0.1231, 0.2208),
('151674', 'SpaGCN', 0.513, 0.5172, 0.4947, 0.0655, 0.2047, 0.5143, 0.7902, 0.2117, 0.5131),
('151674', 'STAGATE', 0.67, 0.6782, 0.6621, 0.0598, 0.0336, 0.5293, 0.8954, 0.1057, 0.5041),
('151674', 'STAIG', 0.5851, 0.5856, 0.5856, 0.0831, 0.0017, 0.07, 0.9043, 0.0953, 0.6073);

-- 样本 151675
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES
('151675', 'CCST', 0.6498, 0.6136, 0.6904, 0.0603, 0.0139, 0.5124, 0.8753, 0.1242, 0.5068),
('151675', 'conST', 0.459, 0.4987, 0.4913, 0.0623, 0.138, 0.4879, 0.8846, 0.1158, 0.4243),
('151675', 'DeepST', 0.5662, 0.637, 0.6186, 0.0602, 0.0398, 0.5399, 0.9149, 0.0848, 0.6587),
('151675', 'GraphST', 0.684, 0.6785, 0.6897, 0.0603, 0.0163, 0.5345, 0.923, 0.0768, 0.5905),
('151675', 'spaceflow', 0.4369, 0.4409, 0.4329, 0.0605, 0.0345, 0.5639, 0.9389, 0.0617, 0.2775),
('151675', 'SpaGCN', 0.5658, 0.6513, 0.6532, 0.0671, 0.2169, 0.5122, 0.756, 0.2423, 0.6472),
('151675', 'STAGATE', 0.5804, 0.5905, 0.5707, 0.0616, 0.0339, 0.554, 0.9054, 0.0943, 0.4464),
('151675', 'STAIG', 0.587, 0.5874, 0.5874, 0.0859, 0.0081, 0.0619, 0.8815, 0.1178, 0.6504);

-- 样本 151676
INSERT INTO performance (sample_id, method_name, nmi, hom, com, chaos, pas, asw, moran, geary, accuracy_score) VALUES
('151676', 'CCST', 0.6864, 0.6589, 0.7163, 0.062, 0.015, 0.4953, 0.9239, 0.0765, 0.6049),
('151676', 'conST', 0.6074, 0.6293, 0.6624, 0.0628, 0.0396, 0.5081, 0.8368, 0.163, 0.6319),
('151676', 'DeepST', 0.5888, 0.6054, 0.6079, 0.0627, 0.0382, 0.5209, 0.9316, 0.0684, 0.5541),
('151676', 'GraphST', 0.6599, 0.6685, 0.6515, 0.0624, 0.0172, 0.555, 0.9461, 0.0535, 0.5653),
('151676', 'spaceflow', 0.4678, 0.4699, 0.4659, 0.063, 0.0344, 0.5449, 0.8528, 0.1465, 0.3024),
('151676', 'SpaGCN', 0.5239, 0.5388, 0.5173, 0.0695, 0.2815, 0.4908, 0.8217, 0.1762, 0.5439),
('151676', 'STAGATE', 0.6895, 0.6946, 0.6843, 0.0627, 0.0312, 0.5303, 0.8788, 0.1193, 0.5831),
('151676', 'STAIG', 0.6316, 0.6321, 0.6321, 0.0927, 0.0055, 0.0636, 0.9657, 0.0346, 0.6248);

-- ============================================
-- 插入Spot数据
-- ============================================

-- 样本 151507
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
('151507', 'AGAATGCGGGTTCGGA-1', 9605, 3970, 0.1330230374135969, 'High'),
('151507', 'CCGCTTGCTGACATGG-1', 9944, 5767, 0.1330230374135969, 'High'),
('151507', 'CATTGATGAACACGCC-1', 10358, 5290, 0.1330230374135969, 'High'),
('151507', 'TCCTGGCGCTGCCTGG-1', 9467, 3969, 0.1330230374135969, 'High'),
('151507', 'TCCATTCCCACTAGAG-1', 10842, 4692, 0.1330230374135969, 'High'),
('151507', 'TTCCGCAGAGAAATAT-1', 9120, 5046, 0.1330230374135969, 'High'),
('151507', 'ATTACTTACTGGGCAT-1', 9051, 5166, 0.1330230374135969, 'High'),
('151507', 'TAAATGCCGTCTCATG-1', 9261, 3849, 0.1330230374135969, 'High'),
('151507', 'CGGTTCAAGTAGGTGT-1', 8912, 5405, 0.1330230374135969, 'High'),
('151507', 'CGTTTACAAGGCAGCT-1', 10221, 5050, 0.1330230374135969, 'High');

-- 样本 151508
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
('151508', 'GGACCTCTAGGCCGCC-1', 4212, 9529, 0.1462036099783925, 'High'),
('151508', 'AGAGTTAGAGACCGAT-1', 8912, 3315, 0.1462036099783925, 'High'),
('151508', 'TGCAGTTTCCTCCCAT-1', 8349, 7386, 0.1462036099783925, 'High'),
('151508', 'CACTCTTCTGCTAGCC-1', 9098, 9664, 0.1462036099783925, 'High'),
('151508', 'ACGCATACGTTTACTA-1', 9168, 9305, 0.1462036099783925, 'High'),
('151508', 'CCGTGAGGCATTCATG-1', 10415, 6913, 0.1462036099783925, 'High'),
('151508', 'GTTAAAGTAGGACTGG-1', 7863, 8462, 0.1462036099783925, 'High'),
('151508', 'TCGCGTCCAGAAGGTC-1', 4153, 6295, 0.1462036099783925, 'High'),
('151508', 'GAGACCCTGCAACGCC-1', 9805, 3917, 0.1462036099783925, 'High'),
('151508', 'TCGCGTAGCAGTGTCC-1', 8962, 9424, 0.1462036099783925, 'High');

-- 样本 151509
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
('151509', 'CGAGTACTAAAGAGGA-1', 4619, 8041, 0.1392075444120633, 'High'),
('151509', 'ACGTAGGAGAGTCGCT-1', 7187, 11064, 0.1392075444120633, 'High'),
('151509', 'AAAGAATGTGGACTAA-1', 9479, 11186, 0.1392075444120633, 'High'),
('151509', 'GAGGTACGCGTGTCCC-1', 6840, 10701, 0.1392075444120633, 'High'),
('151509', 'GCTTGAGTGACCTCTG-1', 10035, 11428, 0.1392075444120633, 'High'),
('151509', 'AGAAGGTTGTAGGTCG-1', 7605, 10339, 0.1392075444120633, 'High'),
('151509', 'GTTCGTTGCGGACCAG-1', 4692, 2602, 0.1392075444120633, 'High'),
('151509', 'ACGAGTACGGATGCCC-1', 9413, 5989, 0.1392075444120633, 'High'),
('151509', 'CTTACATAGATTTCTT-1', 7882, 11548, 0.1392075444120633, 'High'),
('151509', 'GGCCGGCGTCTGCTAT-1', 7674, 10460, 0.1392075444120633, 'High');

-- 样本 151510
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
('151510', 'TGGTATCGCATCCCAA-1', 6921, 3628, 0.1375502466170458, 'High'),
('151510', 'CCATGGCAAACGCTCA-1', 4922, 11561, 0.1375502466170458, 'High'),
('151510', 'GGGCCTAAATGGGCTA-1', 2804, 8052, 0.1375502466170458, 'High'),
('151510', 'CATGCATGGAGACCCT-1', 7061, 3388, 0.1375502466170458, 'High'),
('151510', 'GATGGTGCCCTAGGCA-1', 7611, 3874, 0.1375502466170458, 'High'),
('151510', 'AACTGGGTCCCGACGT-1', 6771, 5072, 0.1375502466170458, 'High'),
('151510', 'CTGCCTAGCCACCAAG-1', 7751, 3634, 0.1375502466170458, 'High'),
('151510', 'TCGGCTAACTTCCCTT-1', 7548, 3031, 0.1375502466170458, 'High'),
('151510', 'GCCCGAGAGTCTAAAT-1', 2857, 10100, 0.1375502466170458, 'High'),
('151510', 'ACATCTCAACGCGTAA-1', 7339, 3149, 0.1375502466170458, 'High');

-- 样本 151669
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
('151669', 'ACTTGTGGATGGAACG-1', 10574, 8745, 0.1428599042513828, 'High'),
('151669', 'CCAGCGGGATCACCAG-1', 11681, 6352, 0.1428599042513828, 'High'),
('151669', 'CTCGTTTCTAATGTTT-1', 10307, 5151, 0.1428599042513828, 'High'),
('151669', 'AAACCGGAAATGTTAA-1', 11675, 8987, 0.1428599042513828, 'High'),
('151669', 'ACGCGAAGTCAGACGA-1', 7202, 8379, 0.1428599042513828, 'High'),
('151669', 'TCCAGCGCTATAAGCG-1', 11125, 8747, 0.1428599042513828, 'High'),
('151669', 'TGTGGTAGGGTGCCTT-1', 11745, 8868, 0.1428599042513828, 'High'),
('151669', 'GCCAATAGGGCATCTC-1', 10237, 5511, 0.1428599042513828, 'High'),
('151669', 'CCTAAATTAACGGTTC-1', 7823, 7542, 0.1428599042513828, 'High'),
('151669', 'TAGTCTGTGACGTTGC-1', 10238, 5271, 0.1428599042513828, 'High');

-- 样本 151670
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
('151670', 'TGTAATGCCTTCGGAC-1', 10526, 2943, 0.1424096473503604, 'High'),
('151670', 'AGTCGTATAAAGCAGA-1', 8719, 10364, 0.1424096473503604, 'High'),
('151670', 'TGACCCAGCATTCCCG-1', 10388, 2942, 0.1424096473503604, 'High'),
('151670', 'TGGTCGTTTGATAGAT-1', 10457, 2823, 0.1424096473503604, 'High'),
('151670', 'CAGAATAACACACGGA-1', 10786, 9171, 0.1424096473503604, 'High'),
('151670', 'CGACCCTTAACGCCGG-1', 3974, 8316, 0.1424096473503604, 'High'),
('151670', 'GAGTAAGGCCACGGGA-1', 4112, 8317, 0.1424096473503604, 'High'),
('151670', 'CGGCAATAAGATCGCC-1', 10580, 9051, 0.1424096473503604, 'High'),
('151670', 'GAGTATGCGCGTGCAT-1', 8031, 10123, 0.1424096473503604, 'High'),
('151670', 'GCAAACCCTACATTAT-1', 8792, 8328, 0.1424096473503604, 'High');

-- 样本 151671
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
('151671', 'CCCGAGTTTCTCCGTA-1', 10628, 8397, 0.142903504376511, 'High'),
('151671', 'TAGTCTTTCCGAATTG-1', 11178, 8638, 0.142903504376511, 'High'),
('151671', 'TACGATCCAAGCCACT-1', 10708, 3007, 0.142903504376511, 'High'),
('151671', 'AATCTCTACTGTGGTT-1', 3883, 7185, 0.142903504376511, 'High'),
('151671', 'TGGTCGTTTGATAGAT-1', 10501, 2886, 0.142903504376511, 'High'),
('151671', 'AAACGCCCGAGATCGG-1', 10638, 3126, 0.142903504376511, 'High'),
('151671', 'GAATGGGCTTATCGAC-1', 3607, 7424, 0.142903504376511, 'High'),
('151671', 'CACCACGCCACACAGA-1', 3745, 7425, 0.142903504376511, 'High'),
('151671', 'GCTCCGGACGTTGATA-1', 10294, 3006, 0.142903504376511, 'High'),
('151671', 'TGCATGGCAGTCTTGC-1', 10433, 2766, 0.142903504376511, 'High');

-- 样本 151672
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
('151672', 'CCACCAACTTTACTGT-1', 5947, 8932, 0.1395309144454005, 'High'),
('151672', 'GATGTTTGTGCGAGAT-1', 5268, 5098, 0.1395309144454005, 'High'),
('151672', 'ATCAGTAGGCAGGGAT-1', 9190, 5467, 0.1395309144454005, 'High'),
('151672', 'GCGGACCGCGTTGTGG-1', 6154, 8813, 0.1395309144454005, 'High'),
('151672', 'TAGCAACCTGTCACAA-1', 4992, 5337, 0.1395309144454005, 'High'),
('151672', 'TTGTTAGCAAATTCGA-1', 6093, 5339, 0.1395309144454005, 'High'),
('151672', 'GCCTAGCGATCTGACC-1', 6094, 5100, 0.1395309144454005, 'High'),
('151672', 'AATAACACTAGAACAA-1', 5809, 8932, 0.1395309144454005, 'High'),
('151672', 'GGGCGGCAAATGAATT-1', 6292, 8574, 0.1395309144454005, 'High'),
('151672', 'GTGAAACGGCGCCACC-1', 9259, 5587, 0.1395309144454005, 'High');

-- 样本 151673
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
('151673', 'ACCGATGGTAGCATCG-1', 9115, 6786, 0.1345711398384866, 'High'),
('151673', 'AGCGCGGGTGCCAATG-1', 9125, 5348, 0.1345711398384866, 'High'),
('151673', 'GGATGTCCTTACCGCA-1', 9047, 6665, 0.1345711398384866, 'High'),
('151673', 'CTAAGTACAGGGCTAC-1', 9829, 3196, 0.1345711398384866, 'High'),
('151673', 'TATAAATCCACAAGCT-1', 5823, 4845, 0.1345711398384866, 'High'),
('151673', 'TCCTCTCCAGTTGTCC-1', 4162, 6031, 0.1345711398384866, 'High'),
('151673', 'GAGGAATGGAGAGGTT-1', 4922, 5677, 0.1345711398384866, 'High'),
('151673', 'TCGTGTATTGGTCACG-1', 10821, 8835, 0.1345711398384866, 'High'),
('151673', 'AGCTGAAGTAAACCAA-1', 8578, 4865, 0.1345711398384866, 'High'),
('151673', 'TCAACTAACGTATAAC-1', 4092, 6150, 0.1345711398384866, 'High');

-- 样本 151674
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
('151674', 'CAACTGCTCATCCGAT-1', 6489, 9587, 0.133719547322478, 'High'),
('151674', 'GAATCTGAACATTCTC-1', 7124, 7555, 0.133719547322478, 'High'),
('151674', 'TCGGCTTGTATCGACG-1', 9313, 9488, 0.133719547322478, 'High'),
('151674', 'GCACAGCACGGGCCGA-1', 5583, 11138, 0.133719547322478, 'High'),
('151674', 'GTTATATTATCTCCCT-1', 6568, 8270, 0.133719547322478, 'High'),
('151674', 'ATAATACCGTTAGCCG-1', 3843, 4416, 0.133719547322478, 'High'),
('151674', 'CAGTCTGTATACTGGG-1', 7262, 7556, 0.133719547322478, 'High'),
('151674', 'ATCGACCCAATACAGA-1', 7054, 7675, 0.133719547322478, 'High'),
('151674', 'TGAATACCGACGCGTA-1', 8342, 10439, 0.133719547322478, 'High'),
('151674', 'CTGCGGGTGAAATGTT-1', 4312, 6217, 0.133719547322478, 'High');

-- 样本 151675
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
('151675', 'AACGTACTGTGGGTAC-1', 5582, 8329, 0.1472500029948995, 'High'),
('151675', 'CTATTGTGTTTGGTCA-1', 9675, 4166, 0.1472500029948995, 'High'),
('151675', 'GGTGCAGAGCCTATCG-1', 9882, 4048, 0.1472500029948995, 'High'),
('151675', 'CATGCTGGCTCCAATT-1', 6853, 4025, 0.1472500029948995, 'High'),
('151675', 'CTCAAGACATTAGCGC-1', 9743, 4286, 0.1472500029948995, 'High'),
('151675', 'TATATTACAAATGTCG-1', 10084, 4648, 0.1472500029948995, 'High'),
('151675', 'GCCTTCAGCCCTACCG-1', 6161, 4500, 0.1472500029948995, 'High'),
('151675', 'CGGTATAGGTATTAGC-1', 9539, 3925, 0.1472500029948995, 'High'),
('151675', 'TAAATGCCGTCTCATG-1', 9814, 3927, 0.1472500029948995, 'High'),
('151675', 'GGCACTGCGGTGGTTT-1', 10245, 10999, 0.1472500029948995, 'High');

-- 样本 151676
INSERT INTO spot (sample_id, spot_name, x_coord, y_coord, consistency_score, complexity_level) VALUES
('151676', 'GACTAACACAGCACCT-1', 8861, 3629, 0.1458104723352921, 'High'),
('151676', 'TCGCCCAACTGACTCC-1', 10168, 3759, 0.1458104723352921, 'High'),
('151676', 'GACTCGGTCGGCGGAT-1', 10031, 3758, 0.1458104723352921, 'High'),
('151676', 'ATTGTGACTTCGCTGC-1', 10167, 3998, 0.1458104723352921, 'High'),
('151676', 'ATTCTTCGTACTTATG-1', 8654, 3747, 0.1458104723352921, 'High'),
('151676', 'AGTACCTTCGAGTGCT-1', 10099, 3878, 0.1458104723352921, 'High'),
('151676', 'AATACAATGTTTCAGG-1', 3960, 5389, 0.1458104723352921, 'High'),
('151676', 'CCTACAAGTCCGGAAT-1', 9893, 3757, 0.1458104723352921, 'High'),
('151676', 'GGTTTGACAAGAAGCT-1', 10372, 4120, 0.1458104723352921, 'High'),
('151676', 'TGTATCAGACTGAAGC-1', 10236, 3879, 0.1458104723352921, 'High');

