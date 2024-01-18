package access
import input

# TODO: implement acces through the abac_api to only allow known users

allow_catalog {
	input.action.operation == "AccessCatalog"
    input.action.resource.catalog.name == "system"
}

allow_catalog {
	input.action.operation == "ExecuteQuery"
}

allow_catalog {
    input.action.operation == "SelectFromColumns"
    input.action.resource.table.catalogName == "system"
}