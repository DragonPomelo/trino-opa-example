package access

import data.abac_am
import future.keywords.in
import input

# Will run if you'll try to use the dbeaver's GUI
allow_catalog {
	input.action.operation == "AccessCatalog"
	input.action.resource.catalog.name == "system"
	abac_am.if_user_exists(input.context.identity.user)
}

allow_catalog {
	input.action.operation == "SelectFromColumns"
	input.action.resource.table.catalogName == "system"
	input.action.resource.table.tableName in ["catalogs", "types"]
}

# If you run the query `show catalogs`
allow_catalog {
	input.action.operation == "ExecuteQuery"
}
