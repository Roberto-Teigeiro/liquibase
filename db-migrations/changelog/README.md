# Database Migrations

This directory contains all database migration scripts managed by Liquibase.

## Directory Structure

```
changelog/
├── changelog.xml              # Master changelog file (references all SQL changesets)
├── changesets/               # Individual SQL migration files
│   ├── 001-initial-schema.sql
│   ├── 002-add-users-table.sql
│   └── ... (additional changesets)
└── README.md                 # This file
```

## Naming Convention

All changeset files should follow this naming pattern:
`XXX-descriptive-name.sql`

Where:
- `XXX` is a 3-digit sequential number (001, 002, 003, etc.)
- `descriptive-name` briefly describes what the changeset does
- Use hyphens to separate words

## Creating New Changesets

1. **Create a new SQL file** in the `changesets/` directory following the naming convention
2. **Add Liquibase headers** at the top of your SQL file:
   ```sql
   --liquibase formatted sql
   
   --changeset author:id
   -- Your SQL statements here
   
   --rollback
   -- Rollback SQL statements here
   ```
3. **Include the file** in `changelog.xml`:
   ```xml
   <include file="changesets/XXX-your-changeset.sql" relativeToChangelogFile="true"/>
   ```

## Best Practices

- **One logical change per file**: Each changeset should represent one logical database change
- **Include rollback statements**: Always provide rollback instructions when possible
- **Use descriptive names**: Make it clear what each changeset does
- **Test thoroughly**: Test both the migration and rollback in development
- **Don't modify existing changesets**: Once a changeset is deployed, create a new one for changes
- **Use contexts and labels**: Tag changesets for different environments when needed

## Running Migrations

### Development Environment
```bash
liquibase --defaults-file=../../../liquibase-dev.properties update
```

### Production Environment
```bash
liquibase --defaults-file=../../../liquibase-prod.properties update
```

## Common Commands

- **Update database**: `liquibase update`
- **Generate SQL**: `liquibase updateSQL`
- **Rollback**: `liquibase rollbackCount 1`
- **Status**: `liquibase status`
- **Validate**: `liquibase validate`

## Troubleshooting

- If checksums fail, check if changesets were modified after deployment
- Use `liquibase clearChecksums` cautiously in development only
- Always backup production databases before running migrations