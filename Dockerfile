# set base image
FROM ubuntu
MAINTAINER Huchangfa <hcf1095246249@qq.com>

RUN apt-get -y update && apt-get install -y nginx && apt-get install -y nodejs && apt-get install -y yarn && apt-get install -y npm
ADD nginx/global.conf /etc/nginx/conf.d/
ADD nginx/nginx.conf /etc/nginx/nginx.conf

COPY package.json /tmp/package.json
RUN cd /tmp && NPM_CONFIG_LOGLEVEL=warn yarn install
COPY . /tmp
RUN cd /tmp && yarn run build

RUN rm -vf /usr/local/nginx/conf/nginx.conf
COPY .nginx_conf /usr/local/nginx/conf/nginx.conf
EXPOSE 80

CMD nginx -g 'daemon off;'