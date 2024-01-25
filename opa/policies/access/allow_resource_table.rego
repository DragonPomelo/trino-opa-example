package access
import input
import data.abac_am
import data.utils
import future.keywords.every
import future.keywords.if
import future.keywords.in

allow_for_resource_table(operation, resource) if {
    operation == "SelectFromColumns"
    user_id := input.context.identity.user
    catalog_name := resource.table.catalogName
    schema_name := resource.table.schemaName
    table_name := resource.table.tableName
    table_obj := abac_am.table_attributes(catalog_name, schema_name, table_name)
    every column in resource.table.columns {
        column_obj := utils.get_column_obj(catalog_name, schema_name, table_obj, column)
		utils.user_can_access_column(user_id, catalog_name, schema_name, table_obj, column_obj)
	}
}

allow_for_resource_table(operation, resource) if {
    operation == "SelectFromColumns"
    utils.user_can_access_catalog(input.context.identity.user, resource.table.catalogName)
    resource.table.schemaName == "information_schema"
	resource.table.tableName == "schemata"
}

allow_for_resource_table(operation, resource) if { 
    operation == "ShowColumns"
    user_id := input.context.identity.user
    catalog_name := resource.table.catalogName
    schema_name := resource.table.schemaName
    table_name := resource.table.tableName
    utils.user_can_access_table(user_id, catalog_name, schema_name, table_name)
}

allow_for_resource_table(operation, resource) if { 
    operation == "SelectFromColumns"
    user_id := input.context.identity.user
    catalog_name := resource.table.catalogName
    schema_name := resource.table.schemaName
    table_name := resource.table.tableName
	utils.user_can_access_catalog(user_id, catalog_name)
    resource.table.schemaName == "information_schema"
    resource.table.tableName in ["columns", "tables"]
}
