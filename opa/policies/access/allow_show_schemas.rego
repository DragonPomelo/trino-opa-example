package access

import data.abac_am
import input
import data.utils


# Will run if you'll try to use the dbeaver's GUI
allow_table_schemas_in_system_catalog {
	input.action.operation == "SelectFromColumns"
	abac_am.if_user_exists(input.context.identity.user)
	input.action.resource.table.catalogName == "system"
	input.action.resource.table.tableName == "schemas"
}


# --------------------------------- #
# deals with show schemas

allow_show_schema{
	allow_access_information_schema
}

allow_show_schema {
	input.action.operation == "ShowSchemas"
	abac_am.if_user_exists(input.context.identity.user)
	utils.user_can_access_catalog(input.context.identity.user, input.action.resource.catalog.name)
}

# for retriving schemas information
allow_access_information_schema {
	input.action.operation == "SelectFromColumns"
	abac_am.if_user_exists(input.context.identity.user)
	utils.user_can_access_catalog(input.context.identity.user, input.action.resource.table.catalogName)
	input.action.resource.table.schemaName == "information_schema"
	input.action.resource.table.tableName == "schemata"
}

# --------------------------------- #


# --------------------------------- #