package trino
import future.keywords.in
import future.keywords.if
import future.keywords.contains

default allow := true
column_resource := input.action.resource.column

table_resource := input.action.resource.table
is_admin {
    input.context.identity.user == "admin"
}

rowFilters contains {"expression": "nationkey <> 2"} if {
    print("row_filtering")
    print(input)
    not is_admin
}
columnMask := {"expression": "*****"} if {
    print("column_masking")
    print(input)
    not is_admin
    column_resource.columnName == "name"
}

# columnMask := {"expression": "NULL"} if {
#     not is_admin
#     column_resource.columnName == "address"
# }