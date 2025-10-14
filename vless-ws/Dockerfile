FROM alpine:3.19

# 修改1：UUID默认值改为全f
ENV UUID="ffffffff-ffff-ffff-ffff-ffffffffffff" \
    PORT=8081

# 安装Xray核心
RUN apk add --no-cache ca-certificates bash curl \
    && curl -L -o /usr/local/bin/xray \
    "https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64" \
    && chmod +x /usr/local/bin/xray

# 创建配置目录
RUN mkdir -p /etc/xray

# 配置模板 config.template.json
COPY config.template.json /etc/xray/

# 生成配置脚本
RUN echo '#!/bin/bash\n\n# 打印UUID和端口\necho "使用UUID: $UUID, 端口: $PORT"\n\n# 生成Xray配置\nenvsubst < /etc/xray/config.template.json > /etc/xray/config.json\n\n# 启动Xray服务\nxray run -config /etc/xray/config.json' > /usr/local/bin/gen-config.sh \
    && chmod +x /usr/local/bin/gen-config.sh

# 暴露端口
EXPOSE 8081

CMD ["bash", "-c", "gen-config.sh"]