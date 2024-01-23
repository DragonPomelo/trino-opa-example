package access
import future.keywords.if
import data.abac_am
import data.utils
import input

allow_show_columns if {
	input.action.operation == "ShowColumns"
    abac_am.if_user_exists(input.context.identity.user)
    user_id := input.context.identity.user
    catalog_name := input.action.resource.table.catalogName
    schema_name := input.action.resource.table.schemaName
    table_name := input.action.resource.table.tableName
    user_has_access_for_requested_table(user_id, catalog_name, schema_name, table_name)
}

user_has_access_for_requested_table(user_id, catalog_name, schema_name, table_name) if {
     utils.user_can_access_table(user_id, catalog_name, schema_name, table_name)
}