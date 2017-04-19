# set base image
FROM ubuntu
MAINTAINER Huchangfa <hcf1095246249@qq.com>

RUN apt-get -y update && apt-get install -y nginx && apt-get install -y nodejs &&  apt-get install -y npm
ADD nginx/global.conf /etc/nginx/conf.d/
ADD nginx/nginx.conf /etc/nginx/nginx.conf

COPY package.json /tmp/package.json
RUN cd /tmp && NPM_CONFIG_LOGLEVEL=warn npm install
COPY . /tmp
RUN cd /tmp && npm run build

EXPOSE 80

CMD nginx -g 'daemon off;'