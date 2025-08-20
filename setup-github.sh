#!/bin/bash

# GitHub 設置腳本
echo "=== GitHub 倉庫設置 ==="

# 檢查是否已經有遠程倉庫
if git remote -v | grep -q origin; then
    echo "遠程倉庫已存在:"
    git remote -v
    echo
    read -p "是否要更新遠程倉庫 URL? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "請輸入新的 GitHub 倉庫 URL (例如: https://github.com/caloutw/Coder-SSH.git):"
        read -r github_url
        git remote set-url origin "$github_url"
    fi
else
    echo "請輸入 GitHub 倉庫 URL (例如: https://github.com/caloutw/Coder-SSH.git):"
    read -r github_url
    git remote add origin "$github_url"
fi

echo
echo "推送代碼到 GitHub..."
git push -u origin main

echo
echo "推送所有標籤..."
git push origin --tags

echo
echo "✅ GitHub 設置完成！"
echo
echo "GitHub Actions 將自動構建和推送 Docker 映像。"
echo "請確保在 GitHub 倉庫設置中添加以下 secrets:"
echo "  - DOCKER_USERNAME: caloutw"
echo "  - DOCKER_PASSWORD: 您的 Docker Hub 密碼或訪問令牌"
