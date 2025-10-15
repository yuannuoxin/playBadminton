# 使用Alpine最新版
FROM teddysun/xray

WORKDIR /usr/bin/

# 复制配置文件
COPY config.template.json ./
COPY gen-config.sh ./

# 设置脚本可执行
RUN chmod +x ./gen-config.sh

# 启动命令
ENTRYPOINT ["./gen-config.sh"]