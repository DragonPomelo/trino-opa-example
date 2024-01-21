package access

import data.abac_am
import future.keywords.in
import input
import data.utils

# Will run if you'll try to use the dbeaver's GUI
allow_catalog {
	input.action.operation == "AccessCatalog"
	input.action.resource.catalog.name == "system"
	abac_am.if_user_exists(input.context.identity.user)
}
# Will run if you'll try to use the dbeaver's GUI
allow_catalog {
	input.action.operation == "SelectFromColumns"
	input.action.resource.table.catalogName == "system"
	input.action.resource.table.tableName in ["catalogs", "types"]
}


allow_show_catalogs {
	input.action.operation == "ExecuteQuery"
	abac_am.if_user_exists(input.context.identity.user)
}

# Allow to access the catalog if the user has the catalog in the catalog's list
allow_catalog {
    input.action.operation == "AccessCatalog"
    utils.user_can_access_catalog(input.context.identity.user, input.action.resource.catalog.name)
    abac_am.if_user_exists(input.context.identity.user)
}

