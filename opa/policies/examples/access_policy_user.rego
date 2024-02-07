package examples_user
import future.keywords.contains
import future.keywords.every
import future.keywords.if

default allow = false

default single_resource = false


# ================== admin ==================

# allow access to all simple trino requests for admin user
allow if {
	print(input)
	input.context.identity.user == "admin"
}
# access to all batch requests for admin user
single_resource if {
    print(input)
	input.context.identity.user == "admin"
}

# ================== resources access user ==================

# access to tpch catalog resource for user shoham1
single_resource if {
    print(input)
	input.action.operation == "FilterCatalogs"
	input.action.resource.catalog.name == "tpch"
	input.context.identity.user == "shoham1"
}

# access to sf1 resource in tpch catalog for user shoham1
single_resource if {
	input.action.operation == "FilterSchemas"
	input.action.resource.schema.catalogName == "tpch"
	input.action.resource.schema.schemaName == "sf1"
	input.context.identity.user == "shoham1"
}


# access to sf1 resource in tpch catalog for user shoham1
single_resource if {
	input.action.operation == "FilterTables"
	input.action.resource.table.catalogName == "tpch"
	input.action.resource.table.schemaName == "sf1"
    input.action.resource.table.tableName == "customer"
	input.context.identity.user == "shoham1"
}

# access to sf1 resource in tpch catalog for user shoham1
single_resource if {
	input.action.operation == "FilterColumns"
	input.action.resource.table.catalogName == "tpch"
	input.action.resource.table.schemaName == "sf1"
    input.action.resource.table.tableName == "customer"
    input.action.resource.table.column == "name"
	input.context.identity.user == "shoham1"
}


# ================== system access user ==================


# access to tpch trino for user some user
allow if {
	print(input)
	input.action.operation == "AccessCatalog"
    input.action.resource.catalog.name == "tpch"
	input.context.identity.user == "shoham1"
}
# access to tpch.sf1 trino for user some user
allow if {
	print(input)
	input.action.operation == "ShowSchemas"
    input.action.resource.catalog.name == "tpch"
	input.context.identity.user == "shoham1"
}
# allow making show tables under specific schema
allow if {
	print(input)
	input.action.operation == "ShowTables"
    input.action.resource.schema.catalogName == "tpch"
    input.action.resource.schema.schemaName == "sf1"
	input.context.identity.user == "shoham1"
}

# -----------------------------------------------
# for SHOW COLUMNS we need the folowing:

# show columns under specific table
allow if {
	print(input)
	input.action.operation == "ShowColumns"
    input.action.resource.table.catalogName == "tpch"
    input.action.resource.table.schemaName == "sf1"
	input.action.resource.table.tableName == "customer"
	input.context.identity.user == "shoham1"
}

# access to specific column in specific table
allow if {
	print(input)
	input.action.operation == "SelectFromColumns"
    input.action.resource.table.catalogName == "tpch"
    input.action.resource.table.schemaName == "information_schema"
	input.action.resource.table.tableName == "columns"
    input.context.identity.user == "shoham1"
}

# -----------------------------------------------


# access to specific column in specific table
allow if {
	print(input)
	input.action.operation == "SelectFromColumns"
    input.action.resource.table.catalogName == "tpch"
    input.action.resource.table.schemaName == "sf1"
	input.action.resource.table.tableName == "customer"
	every column in input.action.resource.table.columns {
		column == "name"
	}
    input.context.identity.user == "shoham1"
}

allow if {
	print(input)
	url := concat("", ["localhost:8081?user_id=", input.context.identity.user])
	response := http.send({"method": "get", "url": url})
	print("shohhhaaaam")
	print(response)
}

# access to trino for user some user
allow if {
	input.action.operation == "ExecuteQuery"
	input.context.identity.user == "shoham1"
}

# access to trino for user some user
allow if {
	print(input)
	input.action.operation == "AccessCatalog"
    input.action.resource.catalog.name == "system"
	input.context.identity.user == "shoham1"
}
# access to trino for user some user
allow if {
	print(input)
	input.action.operation == "SelectFromColumns"
    input.action.resource.table.catalogName == "system"
    input.context.identity.user == "shoham1"
}



# ================== batch ==================

# ... rest of the policy ...
# this assumes the non-batch response field is called "allow"
batch contains i if {
    some i
    raw_resource := input.action.filterResources[i]
    single_resource with input.action.resource as raw_resource
}

# Corner case: filtering columns is done with a single table item, and many columns inside
# We cannot use our normal logic in other parts of the policy as they are based on sets
# and we need to retain order
batch contains i if {
    some i
    input.action.operation == "FilterColumns"
    count(input.action.filterResources) == 1
    raw_resource := input.action.filterResources[0]
    count(raw_resource["table"]["columns"]) > 0
    new_resources := [
        object.union(raw_resource, {"table": {"column": column_name}})
        | column_name := raw_resource["table"]["columns"][_]
    ]
    single_resource with input.action.resource as new_resources[i]
}