package rls

import data.admin
import data.utils
import future.keywords.if

filter := row_filter if {
	not admin.user_is_admin

	# table_name := input.action.resource.table.tableName
	table_name := utils.table_name
	utils.table_attributes.attributes.row_filter == true
	row_filter_id := utils.table_attributes.attributes.row_filter_id
	filter_key := utils.content_world_attributes.filter_key
	filter_values_string := concat(", ", filter_values_list)
	customer_properties := "datalake.sample.customer_properties"

	expression := sprintf("%v.%v IN (select _s.%v from %v as _s where _s.%v in (%v))", [table_name, row_filter_id, row_filter_id, customer_properties, filter_key, filter_values_string])
	row_filter := {"expression": sprintf("%v", [expression])}
}
