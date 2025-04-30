#!/bin/bash
set -e

host="${DB_HOST:-mysql}"
port="${DB_PORT:-3306}"
user="${DB_USER:-root}"
password="${DB_PASSWORD:-root}"
timeout=60

echo "Waiting for MySQL at $host:$port..."

while ! mysqladmin ping -h"$host" -P"$port" -u"$user" -p"$password" --silent; do
  echo "MySQL is unavailable - sleeping"
  sleep 5
  timeout=$((timeout-5))
  if [ $timeout -le 0 ]; then
    echo "Timeout waiting for MySQL"
    exit 1
  fi
done

echo "MySQL is up - executing command"
exec "$@"