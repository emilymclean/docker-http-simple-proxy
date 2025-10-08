#!/bin/sh

# Fetch the DNS resolver
RESOLVER="$DNS"
if [ -z "$RESOLVER" ]; then
    RESOLVER=$(grep "nameserver" /etc/resolv.conf | awk '{print $2}')
fi

if [ -n "$DNS_VALID_TIMEOUT" ]; then
    RESOLVER="$RESOLVER valid=$DNS_VALID_TIMEOUT"
fi

echo "resolver $RESOLVER;" > /etc/nginx/resolvers.conf


# Goes into the nginx config folder
cd /etc/nginx/conf.d/ || exit 1


# Setup the server config
cat > default.conf <<EOF
# http level config
client_max_body_size ${MAX_BODY_SIZE};

server {
    listen 80 default_server;
    client_max_body_size ${MAX_BODY_SIZE};

    location / {

        # Dynamic IP DNS workaround
        include resolvers.conf;
        set \$upstream "${FORWARD_PROT}://${FORWARD_HOST}:${FORWARD_PORT}";

        proxy_pass                    \$upstream;
        proxy_read_timeout            ${PROXY_READ_TIMEOUT};
        proxy_pass_request_headers    on;
        proxy_set_header Host         \$host;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Protocol \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header Upgrade      \$http_upgrade;
        proxy_set_header Connection   "upgrade";

        client_max_body_size          ${MAX_BODY_SIZE};
        client_body_buffer_size       ${MAX_BUFFER_SIZE};
    }
}
EOF


# Goes back to root folder
cd / || exit 1


# Chain the execution commands
exec "$@"
