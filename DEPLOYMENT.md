# Spatial Transcriptomics 系统部署指南

## 项目概述

本项目是一个空间转录组学分析系统，包含以下组件：

- **前端**：Vue 3 + Vite
- **后端**：Spring Boot 2.7 + MyBatis
- **数据库**：MySQL 8.0+
- **数据分析**：Python 脚本

## 环境要求

- **JDK**: 1.8+
- **Node.js**: 20+
- **Python**: 3.8+
- **MySQL**: 8.0+
- **Maven**: 3.6+

## 项目结构

```
Spatial Transcriptomics/
├── METHODS/          # Python数据分析脚本和数据文件
├── backend/          # Spring Boot后端
├── front/            # Vue前端
└── DEPLOYMENT.md     # 本文件
```

---

## 快速开始

### 1. 克隆项目

将项目文件夹复制到目标机器。

### 2. 准备数据目录

将 `METHODS` 文件夹移动到你想要的位置（例如：`/path/to/your/data/METHODS`），这个目录包含：
- 所有样本的 `_dashboard.html` 文件
- `CCST_original_plots/` 等原始图表文件夹
- `*_plots_with_complex/` 等带复杂标记的图表文件夹
- `*_results.csv` 和 `*_report.txt` 文件

### 3. 数据库配置

#### 3.1 创建数据库

在 MySQL 中执行：

```sql
CREATE DATABASE spatial_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

#### 3.2 配置数据库连接

复制 `backend/src/main/resources/application.properties` 为 `application-local.properties` 并修改：

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/spatial_db?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true
spring.datasource.username=your_username
spring.datasource.password=your_password
```

### 4. 配置后端

复制配置模板：

```bash
cd backend/src/main/resources
cp application.properties.template application.properties
```

编辑 `application.properties`，修改以下配置：

```properties
# 数据库配置（必须修改）
spring.datasource.username=你的MySQL用户名
spring.datasource.password=你的MySQL密码

# 数据根目录（METHODS文件夹的父目录）
# 推荐使用相对路径，避免中文路径乱码问题
data.root-dir=../
```

**重要**：如果路径包含中文，请使用相对路径 `../`，否则可能会出现乱码问题。

### 5. 配置前端（可选）

如果后端部署在其他机器，需要配置前端 API 地址：

```bash
cd front
cp .env.example .env.local
```

编辑 `.env.local`，修改后端地址：

```env
VITE_API_BASE_URL=http://后端机器IP:8080/api
```

### 6. 启动后端

```bash
cd backend
mvn clean install
mvn spring-boot:run
```

后端将在 `http://localhost:8080` 启动。

### 7. 启动前端

```bash
cd front
npm install
npm run dev
```

前端将在 `http://localhost:5173` 启动。

---

## 需要修改的配置文件清单

在别人电脑上运行时，需要修改以下配置文件：

### 1. 后端数据库配置
**文件**: `backend/src/main/resources/application.properties`

```properties
spring.datasource.username=你的MySQL用户名
spring.datasource.password=你的MySQL密码
```

### 2. 前端 API 地址（如果后端不在本机）
**文件**: `front/.env.local`（需要从 `.env.example` 复制）

```env
VITE_API_BASE_URL=http://后端机器IP:8080/api
```

### 3. 数据路径配置
**文件**: `backend/src/main/resources/application.properties`

```properties
# 如果 METHODS 文件夹在项目根目录下，使用相对路径
data.root-dir=../

# 如果使用绝对路径，确保路径正确（注意中文乱码问题）
# data.root-dir=D:/your/path/to/data
```

---

## 详细配置

### 数据库配置说明

数据库包含以下表：
- `sample`: 样本信息
- `method`: 方法信息和文件路径
- `performance`: 性能指标
- `spot`: 差异斑点信息

### 关于文件路径的解决方案

由于原始数据库中存储的是绝对路径，我们提供了两种解决方案：

#### 方案一：使用相对路径 + 配置文件（推荐）

1. 在 `application.properties` 中配置 `data.root-dir`
2. 修改后端代码，将数据库存储的路径与配置的根目录拼接
3. 这样数据库中可以存储相对路径，便于迁移

#### 方案二：重新生成 SQL 脚本

使用提供的 `regenerate_insert_sql.py` 脚本，它会：
- 自动检测当前目录
- 生成包含正确绝对路径的 SQL 插入语句

### 前端 API 地址配置

如果后端部署在其他地址，修改 `front/src/api/index.js`：

```javascript
const API_BASE = 'http://your-backend-host:8080/api'
```

---

## 常见问题

### 1. 文件找不到错误

确保：
- `data.root-dir` 配置正确
- METHODS 文件夹在该目录下
- 数据库中的文件路径与实际路径一致

### 2. 数据库连接失败

检查：
- MySQL 服务是否启动
- 用户名密码是否正确
- 数据库是否已创建

### 3. 前端无法连接后端

检查：
- 后端是否正常启动
- API 地址配置是否正确
- 跨域配置（WebConfig 中已配置允许所有来源）

---

## 生产环境部署

### 后端打包

```bash
cd backend
mvn clean package
java -jar target/backend-1.0.0.jar
```

### 前端打包

```bash
cd front
npm run build
```

将 `dist` 文件夹部署到 Nginx 或其他 Web 服务器。

### Nginx 配置示例

```nginx
server {
    listen 80;
    server_name your-domain.com;

    # 前端静态文件
    location / {
        root /path/to/front/dist;
        try_files $uri $uri/ /index.html;
    }

    # 后端API代理
    location /api {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

---

## 开发者说明

### 修改数据路径配置

如果需要修改代码以支持相对路径，需要修改：
1. `FileController.java` - 使用配置的根目录拼接路径
2. `application.properties` - 添加 `data.root-dir` 配置

### 重新生成数据

如果有新的分析结果，运行：
```bash
cd METHODS
python regenerate_insert_sql.py
```

然后重新执行 SQL 文件更新数据库。

---

## 技术支持

如有问题，请检查：
1. 日志文件（后端日志在控制台）
2. 浏览器开发者工具的 Network 标签
3. 数据库中的路径是否正确
