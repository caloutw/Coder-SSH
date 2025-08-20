#!/bin/bash

# 測試多架構 Docker 構建腳本
# 只進行本地構建，不推送到 Docker Hub

set -e

echo "=== 測試多架構 Docker 構建 ==="
echo "此腳本將測試構建過程，不會推送映像"
echo

# 確保 Docker Buildx 已啟用
docker buildx create --use --name multiarch-builder || true
docker buildx inspect --bootstrap

# 測試構建多架構映像（不推送）
echo "正在測試構建多架構映像..."
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag coder-ssh:test \
  --load \
  .

echo
echo "✅ 測試構建完成！"
echo "映像已構建為: coder-ssh:test"
echo
echo "您可以運行以下命令來測試映像:"
echo "  docker run -d --name test-coder-ssh -p 2222:22 coder-ssh:test"
echo "  ssh -p 2222 ubuntu@localhost"
echo
echo "清理測試映像:"
echo "  docker rmi coder-ssh:test"
