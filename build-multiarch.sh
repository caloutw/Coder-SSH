#!/bin/bash

# 多架構 Docker 構建腳本
# 支援 x86_64 (amd64) 和 ARM64 架構

set -e

# 配置變數
IMAGE_NAME="caloutw/coder-ssh"
VERSION=${1:-latest}
BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
GIT_COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")

echo "=== 多架構 Docker 映像構建工具 ==="
echo "映像名稱: $IMAGE_NAME"
echo "版本: $VERSION"
echo "支援架構: linux/amd64, linux/arm64"
echo "構建時間: $BUILD_DATE"
echo "Git Commit: $GIT_COMMIT"
echo

# 檢查是否已登入 Docker Hub，如果沒有則自動登入
if ! docker info | grep -q "Username"; then
    echo "正在登入 Docker Hub..."
    docker login
fi

echo "開始構建多架構 Docker 映像..."

# 確保 Docker Buildx 已啟用
docker buildx create --use --name multiarch-builder || true
docker buildx inspect --bootstrap

# 構建並推送多架構映像
echo "正在構建並推送映像..."
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag "$IMAGE_NAME:$VERSION" \
  --tag "$IMAGE_NAME:latest" \
  --label "org.opencontainers.image.created=$BUILD_DATE" \
  --label "org.opencontainers.image.revision=$GIT_COMMIT" \
  --label "org.opencontainers.image.version=$VERSION" \
  --push \
  .

echo
echo "✅ 多架構映像構建完成！"
echo
echo "可用的架構:"
docker buildx imagetools inspect "$IMAGE_NAME:$VERSION" --format "{{.Manifest.OS}}/{{.Manifest.Architecture}}"
echo
echo "映像資訊:"
echo "  - 映像名稱: $IMAGE_NAME"
echo "  - 版本: $VERSION"
echo "  - 最新版本: $IMAGE_NAME:latest"
echo "  - 構建時間: $BUILD_DATE"
echo "  - Git Commit: $GIT_COMMIT"
echo
echo "使用範例:"
echo "  docker pull $IMAGE_NAME:latest"
echo "  docker run -d -p 2222:22 $IMAGE_NAME:latest"
echo
echo "Docker Hub 頁面:"
echo "  https://hub.docker.com/r/caloutw/coder-ssh"
