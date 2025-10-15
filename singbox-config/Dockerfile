FROM ghcr.io/sagernet/sing-box

RUN mkdir -p /etc/sing-box
RUN mkdir -p /app/sing-box
WORKDIR /app/sing-box

# 复制配置文件
COPY config.default.json ./
COPY gen-config.sh ./

# 设置脚本可执行
RUN chmod +x ./gen-config.sh

# 启动命令
ENTRYPOINT ["./gen-config.sh"]