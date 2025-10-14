# 使用Alpine最新版
FROM alpine:3.19

# 安装必要工具
RUN apk add --no-cache \
    bash \
    xray \
    gettext \
    curl \
    netcat-openbsd

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