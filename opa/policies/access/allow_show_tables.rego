package access
import future.keywords.if
import data.abac_am
import data.utils
import input

allow_show_tables if {
	input.action.operation == "ShowTables"
	abac_am.if_user_exists(input.context.identity.user)
    user_has_access_for_requested_schema(input.context.identity.user,input.action.resource.schema.catalogName,input.action.resource.schema.schemaName)
}

allow_show_tables if {
    input.action.operation == "SelectFromColumns"
    user_has_access_for_information_schema_and_tables_in_requested_catalog
}

user_has_access_for_information_schema_and_tables_in_requested_catalog if {
	input.action.operation == "SelectFromColumns"
	abac_am.if_user_exists(input.context.identity.user)
	utils.user_can_access_catalog(input.context.identity.user, input.action.resource.table.catalogName)
	input.action.resource.table.schemaName == "information_schema"
	input.action.resource.table.tableName == "columns"
}

user_has_access_for_information_schema_and_tables_in_requested_catalog if {
	input.action.operation == "SelectFromColumns"
	abac_am.if_user_exists(input.context.identity.user)
	utils.user_can_access_catalog(input.context.identity.user, input.action.resource.table.catalogName)
	input.action.resource.table.schemaName == "information_schema"
	input.action.resource.table.tableName == "tables"
}

user_has_access_for_requested_schema(user_id, catalog_name, schema_name) if {
    utils.user_can_access_schema(user_id, catalog_name, schema_name)
}

