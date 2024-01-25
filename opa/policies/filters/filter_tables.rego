package filters
import data.utils
filter_tables {
    input.action.operation == "FilterTables"
    utils.user_can_access_table(input.context.identity.user, input.action.resource.table.catalogName, input.action.resource.table.schemaName, input.action.resource.table.tableName)
}