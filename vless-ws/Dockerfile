FROM alpine:3.19

# 安装依赖
RUN apk add --no-cache \
    bash \
    xray \
    gettext  # 提供envsubst命令

# 创建目录
RUN mkdir -p /etc/xray
WORKDIR /etc/xray

# 复制文件（按顺序）
COPY config.template.json .
COPY gen-config.sh /usr/local/bin/

# 设置权限
RUN chmod +x /usr/local/bin/gen-config.sh

# 暴露端口
EXPOSE 443
EXPOSE 80

# 启动命令
ENTRYPOINT ["/usr/local/bin/gen-config.sh"]