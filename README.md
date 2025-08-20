# Coder-SSH

一個基於 Ubuntu 24.04 的 SSH 開發環境 Docker 映像，支援多架構部署。

## 支援的架構

- **linux/amd64** (x86_64)
- **linux/arm64** (ARM64)

## 快速開始

### 使用預構建映像

```bash
# 拉取最新版本
docker pull caloutw/coder-ssh:latest

# 運行容器
docker run -d \
  --name coder-ssh \
  -p 2222:22 \
  caloutw/coder-ssh:latest
```

### 本地構建多架構映像

#### 方法 1: 使用構建腳本

```bash
# 構建並推送最新版本
./build-multiarch.sh

# 構建並推送指定版本
./build-multiarch.sh v1.0.0
```

#### 方法 2: 手動構建

```bash
# 創建並使用 buildx builder
docker buildx create --use --name multiarch-builder

# 構建並推送多架構映像
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag caloutw/coder-ssh:latest \
  --push \
  .
```

## 環境變數

| 變數名稱 | 預設值 | 說明 |
|---------|--------|------|
| USERNAME | ubuntu | SSH 使用者名稱 |
| PASSWORD | Abcd1234 | SSH 使用者密碼 |
| SUDO_PASSWORD | Abcd1234 | sudo 密碼 |

## 連接資訊

- **SSH 端口**: 22
- **預設使用者**: ubuntu
- **預設密碼**: Abcd1234

## 使用範例

```bash
# 使用自定義端口和密碼
docker run -d \
  --name coder-ssh \
  -p 2222:22 \
  -e USERNAME=developer \
  -e PASSWORD=MySecurePassword123 \
  caloutw/coder-ssh:latest

# SSH 連接
ssh -p 2222 ubuntu@localhost
```

## 自動化部署

本專案包含 GitHub Actions 工作流程，會在推送到 main/master 分支或創建版本標籤時自動構建和推送多架構映像到 Docker Hub。

### 設置 GitHub Secrets

在 GitHub 倉庫設置中添加以下 secrets：

- `DOCKER_USERNAME`: Docker Hub 使用者名稱
- `DOCKER_PASSWORD`: Docker Hub 密碼或訪問令牌

## 專案結構

```
.
├── Dockerfile              # Docker 映像定義
├── init.sh                 # 容器初始化腳本
├── sshd_config            # SSH 服務器配置
├── vscInit.sh             # VS Code 初始化腳本
├── vscInit_README.md      # VS Code 使用說明
├── build-multiarch.sh     # 多架構構建腳本
└── .github/workflows/     # GitHub Actions 工作流程
    └── docker-multiarch.yml
```

## 授權

本專案採用 MIT 授權條款。
