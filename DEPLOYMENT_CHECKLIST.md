# 部署检查清单

## 在新电脑上部署时，需要检查/修改以下内容：

### 1. 环境准备
- [ ] JDK 8+
- [ ] Node.js 20+
- [ ] Python 3.8+
- [ ] MySQL 8.0+
- [ ] Maven 3.6+

### 2. 数据库配置
**文件**: `backend/src/main/resources/application.properties`

```properties
spring.datasource.username=你的MySQL用户名
spring.datasource.password=你的MySQL密码
```

**需要执行的 SQL**:
```sql
CREATE DATABASE spatial_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 3. 数据导入
```bash
cd METHODS
python generate_insert_sql.py --relative
echo "SOURCE insert_data.sql;" | mysql -u 你的用户名 -p spatial_db --default-character-set=utf8mb4
```

### 4. 前端 API 配置（如果后端不在本机）
**文件**: `front/.env.local`（需要创建）

```env
VITE_API_BASE_URL=http://后端机器IP:8080/api
```

### 5. 启动服务

#### Windows:
双击运行 `start.bat`

#### 手动启动:
```bash
# 启动后端
cd backend
mvn spring-boot:run

# 新开终端，启动前端
cd front
npm install
npm run dev
```

### 6. 验证部署
打开浏览器访问 http://localhost:5173

如果能看到样本列表，说明部署成功。

---

## 常见问题

### Q: 数据库连接失败
A: 检查 `application.properties` 中的用户名密码是否正确

### Q: 前端显示"网络错误"
A: 检查后端是否启动成功，检查 `.env.local` 中的 API 地址是否正确

### Q: 图片显示不出来
A: 检查 `application.properties` 中的 `data.root-dir` 配置是否正确

### Q: 中文显示乱码
A: 使用 `--default-character-set=utf8mb4` 参数导入 SQL，使用相对路径配置 `data.root-dir`
