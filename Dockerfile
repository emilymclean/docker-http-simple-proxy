# Based on this image -> https://hub.docker.com/r/picoded/http-simple-proxy
ARG NGINX_VERSION=1.29.1
FROM nginx:${NGINX_VERSION}-alpine
LABEL org.opencontainers.image.authors="Emily McLean <emilymcleandeveloper@gmail.com>"

# Makes only the entry point, no other points needed
RUN mkdir /entrypoint;

# Port to expose, this is currently fixed to 80
EXPOSE 80

#
# Server host to make request to, 
# you may use a named container of "webhost" instead
#
ENV FORWARD_HOST=webhost

# The destination server port
ENV FORWARD_PORT=80

# The forwarding protocall
ENV FORWARD_PROT="http"

# Nginx proxy read timed, default is 600 seconds (10 minutes)
ENV PROXY_READ_TIMEOUT=600

# Client max body size conig (default disabled)
ENV MAX_BODY_SIZE=100M

# Client buffer size, before writing a tmp file
ENV MAX_BUFFER_SIZE=10M

# DNS server to use (if configured)
ENV DNS=""

# DNS Validity timeframe
#
# This can be set as blank to follow DNS declared settings
# intentionally set to 10s to avoid DNS storms
ENV DNS_VALID_TIMEOUT=10s

#
# Prepares the entrypoint primer script, and runs it once
#
COPY primer.sh /entrypoint/primer.sh
RUN /entrypoint/primer.sh

#
# Useful for debugging
#
# RUN cat /etc/nginx/conf.d/default.conf;
# RUN cat /entrypoint/primer.sh;

ENTRYPOINT ["/entrypoint/primer.sh"]
CMD ["nginx", "-g", "daemon off;"]
