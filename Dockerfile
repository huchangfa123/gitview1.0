# set base image
FROM node: latest
MAINTAINER Huchangfa <hcf1095246249@qq.com>

# Install Nginx
ENV NGINX_VERSION 1.10.3-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
	&& echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
						ca-certificates \
						nginx=${NGINX_VERSION} \
						nginx-module-xslt \
						nginx-module-geoip \
						nginx-module-image-filter \
						nginx-module-perl \
						nginx-module-njs \
						gettext-base \
	&& rm -rf /var/lib/apt/lists/*

# npm install 
COPY package.json /tmp/package.json
RUN cd /tmp && NPM_CONFIG_LOGLEVEL=warn yarn install
COPY . /tmp
RUN cd /tmp && yarn run build

# Remove the default Nginx configuration file
RUN rm -rf /usr/share/nginx/html && mv /tmp/dist /usr/share/nginx/html
COPY nginx-site.conf /etc/nginx/conf.d/default.conf

# Expose ports
EXPOSE 80

# Set the default command to execute
# when creating a new container
CMD nginx -g 'daemon off;'