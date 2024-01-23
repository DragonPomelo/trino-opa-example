package filters
import input
import data.utils

filter_schemas {
    input.action.operation == "FilterSchemas"
    utils.user_can_access_schema(input.context.identity.user, input.action.resource.schema.catalogName,  input.action.resource.schema.schemaName)
}