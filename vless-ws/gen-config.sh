#!/bin/bash
set -euo pipefail

# 定义默认值
DEFAULT_UUID="ffffffff-ffff-ffff-ffff-ffffffffffff"
DEFAULT_PORT=8081
DEFAULT_WS_PATH="/ws"

# 设置参数（环境变量可覆盖）
: "${UUID:=$DEFAULT_UUID}"
: "${PORT:=$DEFAULT_PORT}"
: "${WS_PATH:=$DEFAULT_WS_PATH}"

# 校验函数（已验证可用）
validate_uuid() {
    if ! echo "$1" | grep -qE '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'; then
        echo "❌ 错误：无效的UUID格式"
        echo "   示例：a1b2c3d4-e5f6-7890-1234-567890abcdef"
        echo "   当前值：$1"
        exit 1
    fi
}

validate_port() {
    if ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -lt 1 -o "$1" -gt 65535 ]; then
        echo "❌ 错误：端口必须是1-65535之间的数字"
        echo "   当前值：$1"
        exit 1
    fi
}

# 执行校验（函数调用验证）
validate_uuid "$UUID"
validate_port "$PORT"

# 校验模板文件
if [ ! -f "/etc/xray/config.template.json" ]; then
    echo "❌ 错误：未找到模板文件"
    exit 1
fi

# 生成配置文件
envsubst < /etc/xray/config.template.json > /etc/xray/config.json

# 验证配置文件
if ! xray test -config /etc/xray/config.json >/dev/null 2>&1; then
    echo "❌ 生成的配置文件无效"
    cat /etc/xray/config.json
    exit 1
fi

# 启动服务
echo "✅ 配置验证通过"
echo "  UUID: $UUID"
echo "  端口: $PORT"
echo "  路径: $WS_PATH"
exec xray run -config /etc/xray/config.json