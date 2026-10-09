# Spatial Transcriptomics 空间转录组学分析系统

一个用于空间转录组学数据可视化和分析的全栈Web应用。

## 项目结构

```
Spatial Transcriptomics/
├── METHODS/          # 数据分析脚本和数据文件
├── backend/          # Spring Boot 后端
├── front/            # Vue 3 前端
├── README.md         # 本文件
└── DEPLOYMENT.md     # 详细部署文档
```

## 快速开始

### 前置要求

- JDK 8+
- Node.js 20+
- Python 3.8+
- MySQL 8.0+
- Maven 3.6+

### 1. 准备数据

将 `METHODS` 文件夹放置在你想要的位置，例如：
- Windows: `D:/methodsresult/METHODS`
- Linux/Mac: `/home/user/data/METHODS`

### 2. 配置数据库

在 MySQL 中创建数据库：

```sql
CREATE DATABASE spatial_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 3. 生成并导入数据

进入 METHODS 目录，运行脚本生成 SQL：

```bash
cd METHODS
python generate_insert_sql.py --relative
```

导入数据到 MySQL：

```bash
cd METHODS
echo "SOURCE insert_data.sql;" | mysql -u用户名 -p spatial_db --default-character-set=utf8mb4
```

**注意**：使用 `SOURCE` 命令和 `--default-character-set=utf8mb4` 参数确保中文编码正确。

### 4. 配置后端

复制配置模板：

```bash
cd ../backend/src/main/resources
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

### 4b. （可选）配置前端 API 地址

如果后端部署在其他机器，需要配置前端 API 地址：

```bash
cd front
cp .env.example .env.local
```

编辑 `.env.local`，修改后端地址：

```env
VITE_API_BASE_URL=http://后端机器IP:8080/api
```

### 5. 启动后端

```bash
cd ../../..  # 回到 backend 目录
mvn clean install
mvn spring-boot:run
```

后端将在 `http://localhost:8080` 启动。

### 6. 启动前端

```bash
cd ../front
npm install
npm run dev
```

前端将在 `http://localhost:5173` 启动。

## 详细文档

更多详细信息请参阅 [DEPLOYMENT.md](./DEPLOYMENT.md)。

## 路径配置说明

本系统支持灵活的路径配置，解决了绝对路径难以迁移的问题：

### 方案一：使用相对路径（推荐）

1. 使用 `generate_insert_sql.py --relative` 生成包含相对路径的 SQL
2. 在 `application.properties` 中配置 `data.root-dir`
3. 后端会自动将相对路径与根目录拼接

### 方案二：使用绝对路径

1. 使用 `generate_insert_sql.py --absolute` 生成包含绝对路径的 SQL
2. 后端也能兼容这种方式，会自动提取相对路径部分

## 技术栈

- **前端**: Vue 3 + Vite + Element Plus
- **后端**: Spring Boot 2.7 + MyBatis
- **数据库**: MySQL 8.0
- **数据分析**: Python + pandas

## 许可证

MIT License
