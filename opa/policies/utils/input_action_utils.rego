package utils
import future.keywords.if

# TODO: Add functions for filter reasorces

operation := input.action.operation

catalog_name := catalog if {
    catalog := input.action.resource.table.catalogName
} 

catalog_name := catalog if {
    catalog := input.action.resource.column.catalogName
} 

catalog_name := catalog if {
    catalog := input.action.resource.schema.catalogName
}

schema_name := schema if {
    schema := input.action.resource.table.schemaName
} 

schema_name := schema if {
    schema := input.action.resource.column.schemaName
} 

schema_name := schema if {
    schema := input.action.resource.schema.schemaName
} 

table_name := table if {
    table := input.action.resource.table.tableName
}

table_name := table if {
    table := input.action.resource.column.tableName
}

column_name := input.action.resource.column.columnName

column_type := input.action.resource.column.columnType