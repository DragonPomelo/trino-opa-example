# Filters Package

The "filters" package is responsible for managing the rules that enable filtering of resources such as catalogs, schemas, tables, and columns in the Trino-Opa-Example project.

## Overview

In this package, you will find individual files for each resource type. Each file contains a rule that governs the filtering behavior for that specific resource. The naming convention for these files is `filter_<resource>.rego`.

## Resource Files

The package includes the following resource files:

- `filter_catalogs.rego`: Contains the filtering rule for catalogs.
- `filter_schemas.rego`: Contains the filtering rule for schemas.
- `filter_tables.rego`: Contains the filtering rule for tables.
- `filter_columns.rego`: Contains the filtering rule for columns.