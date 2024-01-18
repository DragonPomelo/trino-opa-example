package access
import input
import data.access

allow_schema {
    print(input)
    true
}

allow_schema {
    input.action.operation == "SelectFromColumns"
    input.resource.table.catalogName == "system"
    input.resource.table.tableName == "schemas"
}

allow_schema {
    acces.allow_catalog
}