package access
import future.keywords.if
import data.abac_am
import data.utils

allow_show_tables if {
	input.action.operation == "ShowTables"
    user_has_access_for_requested_schema
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
	input.action.resource.table.tableName == "tables"
}

user_has_access_for_requested_schema if {
    user_has_access_for_at_least_one_table
}

user_has_access_for_at_least_one_table if {
    # TODO implement this rule
    true
}