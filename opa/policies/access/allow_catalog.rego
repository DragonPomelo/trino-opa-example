package access
import input

# TODO: implement acces through the abac_api to only allow known users

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

allow_catalog {
    print(input)
    true
}