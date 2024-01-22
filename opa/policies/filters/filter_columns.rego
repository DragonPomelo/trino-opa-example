package filters

import future.keywords.in
import future.keywords.if
import input
import data.abac_am
import data.utils

filter_columns {
	input.action.operation == "FilterColumns"
    user_id := input.context.identity.user
    catalog_name := input.action.resource.table.catalogName
    schema_name := input.action.resource.table.schemaName
    table_name := input.action.resource.table.tableName
    column_name := input.action.resource.table.column
    user_can_access_column(user_id, catalog_name, schema_name, table_name, column_name)

}

user_can_access_column(user_id,catalog_name,schema_name,table_name,column_name) if {
    table_obj = abac_am.table_attributes(catalog_name, schema_name, table_name)
    some column_obj in table_obj.columns_list
    column_obj.column_name == column_name
    utils.user_can_access_column(user_id ,catalog_name, input.action.resource.table.schemaName,table_obj,column_obj)
}