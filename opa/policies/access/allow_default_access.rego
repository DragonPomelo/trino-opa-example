package access
import data.utils
import data.abac_am
import future.keywords.in
import future.keywords.if
import input


allow_default_access if {
    allow_execute_query
}

allow_default_access if {
    allow_access_catalog_on_system_catalog
}

allow_default_access if {
    allow_sfc_on_system_catalog
}

allow_default_access if {
    allow_system_catalog_jdbc_schema_tables_table
}

allow_default_access if {
    allow_sfc_on_table_schemas_in_system_catalog
}

allow_default_access if {
    allow_sfc_on_table_columns_in_system_catalog
}

allow_execute_query if {
	abac_am.if_user_exists(utils.user_id)
	input.action.operation == "ExecuteQuery"
}

# Will run if you'll try to use the dbeaver's GUI
allow_access_catalog_on_system_catalog if {
	input.action.operation == "AccessCatalog"
	input.action.resource.catalog.name == "system"
}
# Will run if you'll try to use the dbeaver's GUI
allow_sfc_on_system_catalog if {
	input.action.operation == "SelectFromColumns"
	input.action.resource.table.catalogName == "system"
    input.action.resource.table.schemaName = "jdbc"
	input.action.resource.table.tableName in ["catalogs", "types"]
}

allow_system_catalog_jdbc_schema_tables_table if {
    input.action.operation == "SelectFromColumns"
    input.action.resource.table.catalogName = "system"
    input.action.resource.table.schemaName = "jdbc"
    input.action.resource.table.tableName = "tables"
}

# Will run if you'll try to use the dbeaver's GUI
allow_sfc_on_table_schemas_in_system_catalog if {
	input.action.operation == "SelectFromColumns"
	input.action.resource.table.catalogName == "system"
	input.action.resource.table.schemaName = "jdbc"
	input.action.resource.table.tableName == "schemas"
}

allow_sfc_on_table_columns_in_system_catalog if {
    input.action.operation == "SelectFromColumns"
    input.action.resource.table.catalogName = "system"
    input.action.resource.table.schemaName = "jdbc"
    input.action.resource.table.tableName = "columns"
}