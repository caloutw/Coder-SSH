# 多架構 Docker 構建指南

本指南說明如何為 Coder-SSH 專案構建支援 x86_64 (amd64) 和 ARM64 架構的 Docker 映像。

## 支援的架構

- **linux/amd64** (x86_64) - 適用於 Intel/AMD 處理器
- **linux/arm64** (ARM64) - 適用於 Apple Silicon (M1/M2/M3)、ARM 服務器等

## 前置需求

1. **Docker Desktop** (版本 20.10 或更高)
2. **Docker Buildx** (通常隨 Docker Desktop 一起安裝)
3. **Docker Hub 帳號** (用於推送映像)

## 構建方法

### 方法 1: 使用自動化腳本 (推薦)

#### 本地構建並推送

```bash
# 1. 登入 Docker Hub
docker login

# 2. 運行構建腳本
./build-multiarch.sh

# 3. 或指定版本
./build-multiarch.sh v1.0.0
```

#### 測試構建 (不推送)

```bash
# 測試構建過程，不推送到 Docker Hub
./test-build.sh
```

### 方法 2: 手動構建

```bash
# 1. 創建並使用 buildx builder
docker buildx create --name multiarch-builder --use

# 2. 啟動 builder
docker buildx inspect --bootstrap

# 3. 構建並推送多架構映像
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag caloutw/coder-ssh:latest \
  --push \
  .
```

### 方法 3: GitHub Actions 自動化

1. 在 GitHub 倉庫設置中添加 secrets：
   - `DOCKER_USERNAME`: Docker Hub 使用者名稱
   - `DOCKER_PASSWORD`: Docker Hub 密碼或訪問令牌

2. 推送代碼到 main/master 分支或創建版本標籤 (v*)

3. GitHub Actions 將自動構建和推送多架構映像

## 驗證多架構映像

### 檢查映像架構

```bash
# 檢查本地映像
docker buildx imagetools inspect coder-ssh:test

# 檢查遠程映像
docker buildx imagetools inspect caloutw/coder-ssh:latest
```

### 測試不同架構

```bash
# 在 x86_64 機器上測試
docker run --platform linux/amd64 -d -p 2222:22 caloutw/coder-ssh:latest

# 在 ARM64 機器上測試
docker run --platform linux/arm64 -d -p 2222:22 caloutw/coder-ssh:latest
```

## 使用多架構映像

### 拉取映像

```bash
# 拉取最新版本 (自動選擇適合的架構)
docker pull caloutw/coder-ssh:latest

# 拉取特定版本
docker pull caloutw/coder-ssh:v1.0.0
```

### 運行容器

```bash
# 基本運行
docker run -d \
  --name coder-ssh \
  -p 2222:22 \
  caloutw/coder-ssh:latest

# 使用自定義配置
docker run -d \
  --name coder-ssh \
  -p 2222:22 \
  -e USERNAME=developer \
  -e PASSWORD=MySecurePassword123 \
  caloutw/coder-ssh:latest
```

## 故障排除

### 常見問題

1. **構建失敗**: 確保 Docker Desktop 正在運行
2. **推送失敗**: 檢查 Docker Hub 登入狀態
3. **架構不支援**: 確認 Docker Buildx 已正確設置

### 清理資源

```bash
# 清理測試映像
docker rmi coder-ssh:test

# 清理 buildx builder
docker buildx rm multiarch-builder

# 清理所有未使用的映像
docker image prune -a
```

## 效能優化

### 使用緩存

```bash
# 啟用 BuildKit 緩存
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag caloutw/coder-ssh:latest \
  --cache-from type=registry,ref=caloutw/coder-ssh:buildcache \
  --cache-to type=registry,ref=caloutw/coder-ssh:buildcache,mode=max \
  --push \
  .
```

### 並行構建

多架構構建會自動並行執行，無需額外配置。

## 版本管理

建議使用語義化版本控制：

```bash
# 主版本
./build-multiarch.sh v1.0.0

# 次版本
./build-multiarch.sh v1.1.0

# 修補版本
./build-multiarch.sh v1.0.1
```

## 安全注意事項

1. 不要在 Dockerfile 中硬編碼敏感資訊
2. 使用 Docker secrets 或環境變數
3. 定期更新基礎映像
4. 掃描映像中的安全漏洞

## 相關檔案

- `Dockerfile` - 映像定義
- `build-multiarch.sh` - 多架構構建腳本
- `test-build.sh` - 測試構建腳本
- `.github/workflows/docker-multiarch.yml` - GitHub Actions 工作流程
- `.dockerignore` - Docker 構建排除檔案
