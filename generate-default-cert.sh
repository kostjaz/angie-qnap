#!/usr/bin/env sh

set -eu

CERT_DIR="${1:-certs}"
CRT_PATH="$CERT_DIR/default.crt"
KEY_PATH="$CERT_DIR/default.key"

mkdir -p "$CERT_DIR"

openssl req \
  -x509 \
  -nodes \
  -newkey rsa:2048 \
  -keyout "$KEY_PATH" \
  -out "$CRT_PATH" \
  -days 3650 \
  -subj "/CN=default.invalid"

chmod 600 "$KEY_PATH"
chmod 644 "$CRT_PATH"

printf 'Generated %s and %s\n' "$CRT_PATH" "$KEY_PATH"
