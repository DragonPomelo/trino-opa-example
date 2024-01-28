package access
import future.keywords.if
import data.utils

allow_for_resource_schema(operation, resource) if {
    operation == "ShowTables"
    catalog_name := resource.schema.catalogName
    schema_name := resource.schema.schemaName
    utils.user_can_access_schema(utils.user_id, catalog_name, schema_name)
}

allow_for_resource_schema(operation, resource) if {
    operation == "FilterSchemas"
    utils.user_can_access_schema(utils.user_id, resource.schema.catalogName, resource.schema.schemaName)
}