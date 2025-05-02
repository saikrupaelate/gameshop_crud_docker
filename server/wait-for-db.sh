#!/bin/sh
host="$1"
shift

echo "Waiting for MySQL at $host..."
until mysql -h "$host" -u root -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1;" &> /dev/null
do
  sleep 2
done

echo "✅ MySQL is up. Checking database and table..."

# Create the database if it doesn't exist
mysql -h "$host" -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS crudgames;"

# Create the table if it doesn't exist
mysql -h "$host" -u root -p"$MYSQL_ROOT_PASSWORD" crudgames -e "
CREATE TABLE IF NOT EXISTS games (
  idgames INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  cost DECIMAL(10,2),
  category VARCHAR(255)
);
"

echo "✅ Database and table are ready."

exec "$@"
