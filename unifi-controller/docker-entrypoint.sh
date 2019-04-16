#!/bin/bash

chown -R unifi:unifi /usr/lib/unifi

echo "Starting Unifi Controller..."
exec "$@"
