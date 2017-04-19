# 获取相应语言的镜像
FROM mhart/alpine-node 
# 设置该镜像的作者
MAINTAINER huchangfa<hcf1095246249@qq.com>

RUN apk --no-cache add tini git openssh-client \
    && apk --no-cache add --virtual devs tar curl

#Install Caddy Server, and All Middleware
RUN curl "https://caddyserver.com/download/build?os=linux&arch=amd64&features=cors%2Cfilemanager%2Cgit%2Chugo%2Cipfilter%2Cjwt%2Clocale%2Cmailout%2Cminify%2Cprometheus%2Cratelimit%2Crealip%2Csearch%2Cupload%2Ccloudflare%2Cdigitalocean%2Cdnsimple%2Cdyn%2Cgandi%2Cgooglecloud%2Cnamecheap%2Crfc2136%2Croute53%2Cvultr" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy

WORKDIR /gitview
COPY . /gitview/
# 安装nodemoudule里面的包，yarn限制了安装版本，速度更快
RUN npm install
RUN npm run build

RUN apk del devs
RUN cd ./dist

# 把端口对外开放
EXPOSE 80
EXPOSE 443
CMD ["caddy", "-port", "80"]

