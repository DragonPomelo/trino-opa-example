package rls

import data.abac_am
import data.admin
import data.cms
import future.keywords.if
import future.keywords.in

column_name := input.action.resource.column.columnName

column_type := input.action.resource.column.columnType

user_id := input.context.identity.user

catalog_name := input.action.resource.column.catalogName

schema_name := input.action.resource.column.schemaName

table_name := input.action.resource.column.tableName

user_attributes := abac_am.user_attributes(user_id)

table_attributes := abac_am.table_attributes(catalog_name, schema_name, table_name)

filter[row_filter] {
	user_attribute := user_attributes.attributes[_]
	user_attribute.filter_value
	filter_number := user_attribute.filter_value[_]
	content_world := user_attribute.content_world
	expression := sprintf("custkey <> %v", [filter_number])
	row_filter := {"expression": sprintf("%v", [expression])}
}
