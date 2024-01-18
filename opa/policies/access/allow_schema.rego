package access
import input

allow_schema {
    input.action.operation == "SelectFromColumns"
    input.action.resource.table.catalogName == "system"
    input.action.resource.table.tableName == "schemas"
}