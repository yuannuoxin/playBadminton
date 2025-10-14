# 使用Alpine最新版
FROM alpine:3.19

# 替换为阿里云镜像源
# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安装必要工具
RUN apk add --no-cache \
    bash \
    xray-core \
    libstdc++ \  # 添加C++标准库依赖
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