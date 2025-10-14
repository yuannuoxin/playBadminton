# 使用Alpine最新版
FROM alpine:3.19


# 安装基础依赖
RUN apk update && apk add --no-cache \
    bash \
    curl \
    unzip \
    libstdc++ \
    gettext \

# 直接下载并安装Xray-core
RUN curl -L -o xray.zip \
    https://github.com/XTLS/Xray-core/releases/download/v25.9.11/Xray-linux-64.zip \
    && unzip xray.zip -d /usr/local/bin/ \
    && rm xray.zip \
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