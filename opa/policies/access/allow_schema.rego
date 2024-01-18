package access
import input


allow_schema {
    input.action.operation == "SelectFromColumns"
    input.resource.table.catalogName == "system"
    input.resource.table.tableName == "schemas"
}