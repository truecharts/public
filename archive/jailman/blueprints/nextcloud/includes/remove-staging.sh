#!/usr/local/bin/bash
# Remove acme-staging CA from Caddyfile, so Caddy gets production certs

sed -ri.bak 's/-staging//' /usr/local/www/Caddyfile
service caddy restart
