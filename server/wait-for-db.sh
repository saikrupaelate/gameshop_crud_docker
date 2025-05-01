# wait-for-db.sh
#!/bin/sh
host="$1"
shift
until mysql -h "$host" -u root -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1;" &> /dev/null
do
  echo "Waiting for MySQL at $host..."
  sleep 2
done
exec "$@"
