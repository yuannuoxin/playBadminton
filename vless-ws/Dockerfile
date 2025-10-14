# 使用Alpine最新版
FROM alpine:3.19

# 安装Xray核心
RUN apk add --no-cache ca-certificates bash curl \
    && curl -L -o /usr/local/bin/xray \
    "https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64" \
    && chmod +x /usr/local/bin/xray

# 创建工作目录
RUN mkdir -p /etc/xray
WORKDIR /etc/xray

# 复制配置文件
COPY config.template.json /etc/xray/
COPY gen-config.sh /usr/local/bin/

# 设置脚本可执行
RUN chmod +x /usr/local/bin/gen-config.sh

# 启动命令
ENTRYPOINT ["/usr/local/bin/gen-config.sh"]