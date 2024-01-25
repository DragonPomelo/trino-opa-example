# Access Package

This package contains a collection of Rego files that are responsible for allowing access to catalogs, schemas, tables, and columns in a system.

## Files

The package includes the following files, each responsible for a different allow operation:


- `allow.rego`: This file contains the main policy decision point for access control. on this file we will referance to `allow_default_access.rego` and `allow_resource.rego`

- `allow_default_access.rego`: This file might contain rules for default access permissions. It could define what actions are allowed or denied by default when no specific rules apply.

- `allow_resource.rego`: This file might contain general rules for resource access. This file contain rule that point to the resource file

- `allow_resource_catalog.rego`: This file contains rules for access to catalog resource. It define what actions are allowed or denied on catalogs.

- `allow_resource_schema.rego`: This file contains rules for access to schema resource. It define what actions are allowed or denied on schemas.

- `allow_resource_table.rego`: This file contains rules for access to table resource. It define what actions are allowed or denied on tables.