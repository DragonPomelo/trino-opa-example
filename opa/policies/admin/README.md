# Admin Package

This package contains the rules for handling admin user permissions.

## Package Structure

The admin package consists of a single rego file called `admin.rego`. This file contains the `allow_admin` rule, which is used by the main policy to grant admin permissions to admin users.

## Rule: allow_admin

The `allow_admin` rule is responsible for determining whether a user should be granted admin permissions. It is used by the main policy to make authorization decisions for admin users.

### Example Usage
