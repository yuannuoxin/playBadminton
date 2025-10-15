# 阶段1：引用文件提供阶段
FROM teddysun/xray AS xray-provider

# 使用Alpine最新版
FROM alpine

# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache bash
# RUN apk add --no-cache curl
# RUN apk add --no-cache envsubst
# RUN apk add --no-cache xray



# https://gh.registry.cyou/
# 直接下载并安装Xray-core
# RUN curl -L -o xray.zip \
#     https://github.com/XTLS/Xray-core/releases/download/v25.9.11/Xray-linux-64.zip \
#     && unzip xray.zip -d ./ \
#     && rm xray.zip \
#     && chmod +x ./xray

RUN mkdir -p /var/log/xray /usr/share/xray
# 从文件提供阶段复制文件
COPY --from=xray-provider /usr/share/xray/* /usr/share/xray/
COPY --from=xray-provider /usr/bin/xray /usr/bin/


WORKDIR /usr/bin/

# 复制配置文件
COPY config.template.json ./
COPY gen-config.sh ./

# 设置脚本可执行
RUN chmod +x ./gen-config.sh

# 启动命令
ENTRYPOINT ["./gen-config.sh"]