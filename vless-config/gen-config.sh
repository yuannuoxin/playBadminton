#!/bin/bash
set -euo pipefail

# 定义默认值
DEFAULT_CONFIG_URL=""


export CONFIG_URL="${CONFIG_URL:=$DEFAULT_CONFIG_URL}"  # 获取配置文件URL


# ========================================
# 函数：带重试机制下载文件
# 参数：URL, 输出文件路径
# 返回：0 成功，1 失败
# ========================================
download_with_retry() {
    local url="$1"
    local output_file="$2"
    local max_retries=10
    local retry_count=0

    echo "📥 正在从 $url 下载配置文件... $output_file"

    until wget -qL -O "$output_file" "$url" 2>/dev/null; do
        retry_count=$((retry_count + 1))
        if [ $retry_count -lt $max_retries ]; then
            echo "⚠️  下载失败，正在重试... ($retry_count/$max_retries)"
            sleep 2
        else
            echo "❌ 下载失败，已达到最大重试次数 ($max_retries)"
            return 1
        fi
    done

    echo "✅ 配置文件下载完成"
    return 0
}

# 处理配置文件
if [ -n "$CONFIG_URL" ]; then
    # 如果提供了配置文件URL，则下载配置文件
    echo "📥 正在从 $CONFIG_URL 下载配置文件..."
    if ! download_with_retry  "$CONFIG_URL" ./config.json; then
        echo "❌ 错误：无法从 $CONFIG_URL 下载配置文件"
        cp ./config.default.json ./config.json
    fi
fi

# 验证配置文件
if ! ./xray -test -config ./config.json >/dev/null 2>&1; then
    echo "❌ 生成的配置文件无效"
    cat ./config.json
    exit 1
fi

# 启动服务
echo "✅ 配置验证通过"
if [ -z "$CONFIG_URL" ]; then
  cat ./config.json
else
    echo "  配置文件来源: $CONFIG_URL"
fi
exec ./xray run -config ./config.json