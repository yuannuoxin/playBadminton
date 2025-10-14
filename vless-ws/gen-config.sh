#!/bin/bash
set -e

# 参数校验
: "${UUID:?Error: UUID environment variable not set}"
WS_PATH=${WS_PATH:-/ws}  # 默认路径

# 使用envsubst替换模板变量
envsubst < /etc/xray/config.template.json > /etc/xray/config.json

# 启动Xray（替换为实际命令）
exec xray run -config /etc/xray/config.json