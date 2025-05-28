# Liquibase Database Migration Project

This project manages database schema changes using Liquibase with SQL-based changesets.

## Project Structure

```
project-root/
├── db-migrations/
│   ├── changelog/
│   │   ├── changelog.xml                # Master changelog (references SQL files)
│   │   ├── changesets/
│   │   │   ├── 001-initial-schema.sql   # Initial database schema
│   │   │   ├── 002-add-users-table.sql  # User management tables
│   │   │   └── ... (other SQL changesets)
│   │   └── README.md                    # Detailed migration documentation
│   └── output/                          # Generated SQL files (gitignored)
├── liquibase-dev.properties             # Development environment config
├── liquibase-prod.properties            # Production environment config
├── .gitignore                           # Git ignore rules
└── README.md                            # This file
```

## Quick Start

### Prerequisites

1. **Install Liquibase**: Download from [liquibase.org](https://www.liquibase.org/download)
2. **Database Driver**: Download the JDBC driver for your database
3. **Database Access**: Ensure you have connection details for your database

### Configuration

1. **Update database connection**: Edit `liquibase-dev.properties` with your database details
2. **Production setup**: Configure `liquibase-prod.properties` for production environment
3. **Security**: Use environment variables for sensitive data in production

### Running Migrations

#### Development Environment
```bash
# Navigate to project root
cd c:\Users\ID140\Documents\liquibase

# Run migrations
liquibase --defaults-file=liquibase-dev.properties update

# Check status
liquibase --defaults-file=liquibase-dev.properties status

# Generate SQL without executing
liquibase --defaults-file=liquibase-dev.properties updateSQL
```

#### Production Environment
```bash
# Run migrations in production
liquibase --defaults-file=liquibase-prod.properties update

# Validate before running
liquibase --defaults-file=liquibase-prod.properties validate
```

## Environment Variables

For production security, set these environment variables:

```bash
# Windows (PowerShell)
$env:DB_USERNAME="your_username"
$env:DB_PASSWORD="your_password"

# Linux/Mac
export DB_USERNAME="your_username"
export DB_PASSWORD="your_password"
```

## Common Commands

| Command | Description |
|---------|-------------|
| `liquibase update` | Apply all pending changesets |
| `liquibase status` | Show pending changesets |
| `liquibase updateSQL` | Generate SQL without executing |
| `liquibase rollbackCount 1` | Rollback the last changeset |
| `liquibase validate` | Validate changelog |
| `liquibase clearChecksums` | Clear checksums (dev only) |

## Adding New Migrations

1. Create a new SQL file in `db-migrations/changelog/changesets/`
2. Follow the naming convention: `XXX-descriptive-name.sql`
3. Add Liquibase headers and rollback statements
4. Include the file in `changelog.xml`

See `db-migrations/changelog/README.md` for detailed instructions.

## Best Practices

- ✅ Never modify existing changesets once deployed
- ✅ Always include rollback statements
- ✅ Test migrations in development first
- ✅ Use descriptive changeset names
- ✅ Back up production databases before migrations
- ✅ Use environment-specific contexts when needed

## Troubleshooting

- **Checksum failures**: Usually means a changeset was modified after deployment
- **Connection issues**: Verify database URL, credentials, and network access
- **Lock issues**: Another process may be running migrations simultaneously

## Support

For Liquibase documentation and support:
- [Official Documentation](https://docs.liquibase.com/)
- [Community Forum](https://forum.liquibase.org/)
- [GitHub Issues](https://github.com/liquibase/liquibase)
