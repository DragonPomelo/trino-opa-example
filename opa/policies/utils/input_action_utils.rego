package utils

# TODO: Add functions for filter reasorces

operation := input.action.operation

catalog_name := catalog {
    catalog := input.action.resource.table.catalogName
} 

catalog_name := catalog {
    catalog := input.action.resource.column.catalogName
} 

catalog_name := catalog {
    catalog := input.action.resource.schema.catalogName
}

schema_name := schema {
    schema := input.action.resource.table.schemaName
} 

schema_name := schema {
    schema := input.action.resource.column.schemaName
} 

schema_name := schema {
    schema := input.action.resource.schema.schemaName
} 

table_name := table {
    table := input.action.resource.table.tableName
}

table_name := table {
    table := input.action.resource.column.tableName
}

column_name := input.action.resource.column.columnName

column_type := input.action.resource.column.columnType