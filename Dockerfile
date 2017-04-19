# set base image
FROM node:latest
MAINTAINER Huchangfa <hcf1095246249@qq.com>

RUN yum install -y pcre-devel wget net-tools gcc zlib zlib-devel make openssl-devel
ADD http://nginx.org/download/nginx-1.12.0.tar.gz
RUN tar zxvf nginx-1.12.0.tar.gz .
RUN mkdir -p /usr/local/nginx
RUN cd nginx-1.12.0 && ./configure --prefix=/usr/local/nginx && make && make install

COPY package.json /tmp/package.json
RUN cd /tmp && NPM_CONFIG_LOGLEVEL=warn yarn install
COPY . /tmp
RUN cd /tmp && yarn run build

RUN rm -vf /usr/local/nginx/conf/nginx.conf
COPY .nginx_conf /usr/local/nginx/conf/nginx.conf
EXPOSE 80

CMD nginx -g 'daemon off;'