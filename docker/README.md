# Oracle Database Docker Setup for Liquibase

This directory contains Docker configuration to run Oracle Database XE locally for Liquibase development.

## Prerequisites

1. **Docker Desktop**: Install Docker Desktop for Windows
2. **Oracle Account**: You need an Oracle account to pull the Oracle Database image
3. **Docker Login**: Login to Oracle Container Registry

## Setup Instructions

### 1. Login to Oracle Container Registry

```powershell
# Login to Oracle Container Registry (you need an Oracle account)
docker login container-registry.oracle.com
# Enter your Oracle username and password
```

### 2. Start Oracle Database

```powershell
# Navigate to the liquibase project directory
cd "c:\Users\ID140\Documents\liquibase"

# Start Oracle Database
docker-compose up -d oracle-db

# View logs to monitor startup (Oracle takes 2-3 minutes to start)
docker-compose logs -f oracle-db
```

### 3. Wait for Database Initialization

Oracle XE takes several minutes to start up completely. You'll see:
```
DATABASE IS READY TO USE!
```

### 4. Verify Connection

```powershell
# Test connection using sqlplus (if installed)
sqlplus admin/admin_password@localhost:1521/XE

# Or test with Liquibase
liquibase --defaults-file=liquibase-dev.properties status
```

## Database Connection Details

- **Host**: localhost
- **Port**: 1521
- **SID**: XE
- **Username**: admin
- **Password**: admin_password
- **JDBC URL**: `jdbc:oracle:thin:@localhost:1521:XE`

## Management Tools

### Adminer (Web-based)
Access at: http://localhost:8080
- System: Oracle
- Server: oracle-db:1521/XE
- Username: admin
- Password: admin_password

### Oracle Enterprise Manager Express
Access at: https://localhost:5500/em
- Username: admin
- Password: admin_password

## Docker Commands

```powershell
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs oracle-db

# Access Oracle container
docker exec -it oracle-xe-liquibase bash

# Connect to Oracle from container
docker exec -it oracle-xe-liquibase sqlplus admin/admin_password@localhost:1521/XE
```

## Troubleshooting

### Oracle Won't Start
- Ensure Docker has enough memory (minimum 2GB)
- Check Docker logs: `docker-compose logs oracle-db`
- Oracle XE requires significant startup time

### Connection Refused
- Wait for Oracle to fully initialize (check logs)
- Verify port 1521 is not in use by another service
- Check Windows Firewall settings

### Permission Issues
- Run PowerShell as Administrator
- Ensure Docker Desktop has proper permissions

## Cleanup

```powershell
# Stop and remove containers
docker-compose down

# Remove volumes (this deletes all data!)
docker-compose down -v

# Remove Oracle image (if needed)
docker rmi container-registry.oracle.com/database/express:21.3.0-xe
```

## Alternative: Oracle Database Free

If you prefer Oracle Database 23c Free:

```yaml
# In docker-compose.yml, replace the image line with:
image: container-registry.oracle.com/database/free:latest
```
