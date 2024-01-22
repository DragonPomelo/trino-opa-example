package rls

import data.abac_am
import data.admin
import data.cms
import future.keywords.if
import future.keywords.in

user_id := input.context.identity.user

catalog_name := input.action.resource.table.catalogName

schema_name := input.action.resource.table.schemaName

table_name := input.action.resource.table.tableName

user_attributes := abac_am.user_attributes(user_id)

table_attributes := abac_am.table_attributes(catalog_name, schema_name, table_name)

content_world_attributes := abac_am.content_world_attributes(table_attributes.attributes.content_world)

filter[row_filter] {
    table_attributes.attributes.row_filter == true
    filter_feild := content_world_attributes.filter_key
	user_attribute := user_attributes.attributes[_]
    row_filtering_needed(user_attribute)
	filter_value := user_attribute.filter_value[_]
	expression := sprintf("%v <> %v", [filter_feild, filter_value])
	row_filter := {"expression": sprintf("%v", [expression])}
}

row_filtering_needed(user_attribute) {
    user_attribute.filter_value
    user_attribute.content_world == table_attributes.attributes.content_world
}
