package access
import input

allow_catalog {
	input.action.operation == "AccessCatalogs"
}

allow_catalog {
	input.action.operation == "ExecuteQuery"
}

allow_catalog {
    input.action.operation == "SelectFromColumns"
    input.resource.table.catalogName == "system"
    input.resource.table.tableName == "catalogs"
}