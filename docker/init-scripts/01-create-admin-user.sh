#!/bin/bash
# Oracle Database Initialization Script
# This script runs after the Oracle database is created

echo "Starting Oracle Database initialization for Liquibase..."

# Connect to Oracle and create the ADMIN user and schema
sqlplus -s sys/OraclePassword123@localhost:1521/XE as sysdba <<EOF

-- Create the ADMIN user for Liquibase
CREATE USER ADMIN IDENTIFIED BY admin_password
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

-- Grant necessary privileges to ADMIN user
GRANT CONNECT, RESOURCE, DBA TO ADMIN;
GRANT CREATE SESSION TO ADMIN;
GRANT CREATE TABLE TO ADMIN;
GRANT CREATE SEQUENCE TO ADMIN;
GRANT CREATE VIEW TO ADMIN;
GRANT CREATE PROCEDURE TO ADMIN;
GRANT CREATE TRIGGER TO ADMIN;
GRANT CREATE SYNONYM TO ADMIN;
GRANT CREATE TYPE TO ADMIN;

-- Grant tablespace quota
ALTER USER ADMIN QUOTA UNLIMITED ON USERS;

-- Create the DATA tablespace if it doesn't exist (optional, for your schema)
-- CREATE TABLESPACE DATA
-- DATAFILE '/opt/oracle/oradata/XE/data01.dbf' SIZE 100M
-- AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;

-- Grant quota on DATA tablespace (if created)
-- ALTER USER ADMIN QUOTA UNLIMITED ON DATA;

-- Show user creation status
SELECT username, account_status, default_tablespace 
FROM dba_users 
WHERE username = 'ADMIN';

COMMIT;
EXIT;
EOF

echo "Oracle Database initialization completed successfully!"
echo "ADMIN user created with password: admin_password"
echo "Connection string: jdbc:oracle:thin:@localhost:1521:XE"
